import os.path
import sys
import typing
from email.policy import default
from mmap import mmap

import click
import tree_sitter_haskell
from tree_sitter import Language, Parser

HS_LANGUAGE = Language(tree_sitter_haskell.language())


def in_import_node(node) -> bool:
    while node is not None:
        if node.type == "import":
            return True

        node = node.parent

    return False


@click.command(name="haskell-taboo-py", add_help_option=False)
@click.argument("taboo_file", type=click.Path(exists=True, dir_okay=False),
                default=os.path.join(os.path.dirname(os.path.abspath(__file__)), "taboo.txt"))
@click.argument("source_path", type=click.Path(exists=True, dir_okay=False), nargs=-1)
def main(taboo_file: str, source_path: tuple[str, ...]) -> int:
    # search $CWD/src/* if no paths are provided
    if len(source_path) == 0:
        if not os.path.isdir("src"):
            raise click.BadParameter(f"Source path(s) not specified and `src` directory not found in {os.getcwd()}")
        source_path = map(
            lambda file: os.path.join("src", file),
            os.listdir(os.path.join(os.getcwd(), "src"))
        )

    # initialize taboo words set from taboo file
    taboo_words: set[bytes] = set()
    with open(taboo_file, mode="rt", encoding="utf-8", newline=None) as f:
        for line in f:
            taboo_words.add(line.strip().encode("utf-8"))

    # create a tree-sitter Haskell parser and variable query
    parser = Parser(HS_LANGUAGE)
    query = HS_LANGUAGE.query("(variable) @variable-name")

    seen_taboo_word = False

    # python click does argument expansion for us, so we can iterate over the source paths
    for spath in source_path:
        with open(spath, mode="r+b") as sfh:
            # we can map the file into memory as it is not expected to change while this program is running
            with mmap(sfh.fileno(), 0) as smap:
                sb = typing.cast(bytes, smap)
                parse_tree = parser.parse(sb)

                qc = query.captures(parse_tree.root_node)
                variable_names = qc["variable-name"]

                variable_names.sort(key=lambda node: node.start_byte)

                for variable_name_node in variable_names:
                    variable_name: bytes = variable_name_node.text
                    if variable_name not in taboo_words:
                        continue

                    if in_import_node(variable_name_node):
                        continue

                    if not seen_taboo_word:
                        print("ERROR: Banned identifiers found")
                        print("Found the following issues:")

                        seen_taboo_word = True

                    # we can search for the bytes 0xA (LF) and 0xD (CR)
                    # assuming UTF-8, we don't have to worry about those bytes occurring naturally
                    # multi-byte sequences are fully within the 0x80-0xFF range

                    start_byte = variable_name_node.start_byte
                    end_byte = variable_name_node.end_byte

                    # start_byte will never be a newline
                    # start_byte-1 is newline -> result from enumerate is 1 -> start_byte is start
                    # start_byte-2 is newline -> result from enumerate is 2 -> start_byte-1 is start
                    # start_byte-(start_byte+1) is newline -> result from enumerate is (start_byte+1) -> 0 is start
                    line_start: int = start_byte - (next(
                        filter(lambda iv: (iv[1] == 0x0A) or (iv[1] == 0x0D),
                               enumerate(smap[start_byte - len(smap)::-1])),
                        (start_byte + 1, 0)
                    )[0] - 1)

                    # end_byte will never be a newline
                    # end_byte+1 is newline -> result from enumerate is 0
                    # end_byte+2 is newline -> result from enumerate is 1
                    # end_byte+(len(smap) - end_byte) is newline -> result from enumerate is (len(smap) - end_byte)-1
                    line_end: int = end_byte + (next(
                        filter(lambda iv: (iv[1] == 0x0A) or (iv[1] == 0x0D), enumerate(smap[end_byte:])),
                        (len(smap) - end_byte - 1, 0)
                    )[0] + 1)

                    pre_banned = smap[line_start:start_byte].decode("utf-8")
                    banned = variable_name.decode("utf-8")
                    post_banned = smap[end_byte:line_end].decode("utf-8")

                    row = variable_name_node.start_point.row
                    column = variable_name_node.start_point.column

                    # SGI 1 -> bold
                    # SGI 91 -> light red
                    # SGI 0 -> reset
                    print(f"({spath}:{row}:{column}) {pre_banned}\033[1;91m{banned}\033[0m{post_banned}")

    if seen_taboo_word:
        return 1
    else:
        return 0


if __name__ == "__main__":
    sys.exit(main(standalone_mode=False))
