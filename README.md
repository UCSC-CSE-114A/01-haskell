# Assignment 1: Intro to Haskell (65 points)

## Due by Monday 10/18 11:59pm


## Overview

The objective of this assignment is for you to gain some
hands-on experience with Haskell. All the problems require
relatively little code ranging from 2 to 15 lines.
If any function requires more than that, you can be
sure that you need to rethink your solution.

**Start Early!** Haskell, while simple,
may seem foreign at first, particularly when 
it comes to recursion and list manipulation.

## Structure and Constraints

The assignment is in two files:

1. [src/Hw1.hs](/src/Hw1.hs) has skeleton functions
   with missing bodies that you will fill in.

2. [tests/Test.hs](/tests/Test.hs) has some sample tests
   and testing code that you will use to check your
   assignments before submitting. You won't be modifying this file.

You should only need to modify the parts of the files which say:

```haskell
error "TBD: ..."
```

with suitable Haskell implementations.

However, if you're asked to fill in a function definition, such as:

```haskell
f xs = error "TBD: ..."
```

you are also allowed to split this definition into multiple equations, like so:

```haskell
f []     = ...
f (x:xs) = ...
```

You are allowed to use any library function on integers,
but only the following three library functions on lists: `length`, `(++)` (append), `(==)` (is equal)


## Assignment Testing and Evaluation

Most of the points will be awarded automatically by
evaluating your functions against a given test suite.

[Test.hs](/tests/Test.hs) contains a very small suite
of tests which gives you a flavor of of these tests.
When you run

```shell
$ stack test
```

Your last lines should have

```
All N tests passed (...)
OVERALL SCORE = ... / ...
```

**or**

```
K out of N tests failed
OVERALL SCORE = ... / ...
```

**If your output does not have one of the above your code will receive a zero**

If for some reason, you cannot get the code to compile,
leave it as is with the `error ...` with your partial
solution enclosed below as a comment.

The other lines will give you a readout for each test.
You are encouraged to try understanding the testing code,
but you will not be graded on this.

## Assignment Submission

We will grade your assignment based on the latest state
of your repository prior to the due date. Make sure to
push your changes to your repo!

## Problem 1: [Roots and Persistence](http://mathworld.wolfram.com/AdditivePersistence.html)

### (a) 10 points

Fill in the implementation of

```haskell
sumList :: [Int] -> Int
sumList xs = error "TBD:sumList"
```

such that `sumList xs` returns the sum of the integer elements of
`xs`. Once you have implemented the function, you should get the following
behavior at the prompt:

```haskell
ghci> sumList [1, 2, 3, 4]
10

ghci> sumList [1, -2, 3, 5]
7

ghci> sumList [1, 3, 5, 7, 9, 11]
36
```

## (b) 10 points

Fill in the implementation of the function

```haskell
digitsOfInt :: Int -> [Int]
digitsOfInt n = error "TBD:digitsOfInt"
```

such that `digitsOfInt n`

* returns `[]` if `n` is not positive, and otherwise
* returns the list of digits of `n` in the order in which they appear in `n`.

Once you have implemented the function, you should get the following behavior:

```haskell
ghci> digitsOfInt 3124
[3, 1, 2, 4]

ghci> digitsOfInt 352663
[3, 5, 2, 6, 6, 3]
```

### (c) 10+10 points

Consider the process of taking a number, adding its digits,
then adding the digits of the number derived from it, etc.,
until the remaining number has only one digit.
The number of additions required to obtain a single digit
from a number `n` is called the *additive persistence* of `n`,
and the digit obtained is called the *digital root* of `n`.

For example, the sequence obtained from the starting number
`9876` is `9876 -> 30 -> 3`. It takes `2` steps (additive persistence)
to reach the digital root of `3`.

Write two functions

```haskell
additivePersistence :: Int -> Int
additivePersistence n = error "TBD:additivePersistence"

digitalRoot :: Int -> Int
digitalRoot n = error "TBD:digitalRoot"
```

that take positive integer arguments `n` and return respectively
the additive persistence and the digital root of `n`. Once you
have implemented the functions, you should get the following
behavior at the prompt:

```haskell
ghci> additivePersistence 9876
2

ghci> additivePersistence 99999
2

ghci> additivePersistence 1
0

ghci> digitalRoot 9876
3

ghci> digitalRoot 99999
9

ghci> digitalRoot 1
1
```

## Problem 2: Palindromes

### (a) 15 points

Implement a function:

```haskell
listReverse :: [a] -> [a]
listReverse xs = error "TBD:listReverse"
```

such that `listReverse [x1,x2,...,xn]` returns the list `[xn,...,x2,x1]`
i.e. the input list but with the values in reversed order.
You should get the following behavior:

```haskell
ghci> listReverse [1, 2, 3, 4]
[4, 3, 2, 1]

ghci> listReverse ["a", "b", "c", "d"]
["d", "c", "b", "a"]
```

### (b) 10 points

A *palindrome* is a word that reads the same from left-to-right and
right-to-left. Write a function

```haskell
palindrome :: String -> Bool
palindrome w = error "TBD:palindrome"
```

such that `palindrome w` returns `True` if the string is a palindrome and
`False` otherwise. You should get the following behavior:

```haskell
ghci> palindrome "malayalam"
True
ghci> palindrome "myxomatosis"
False
```
