#!/bin/bash
badfile=$1
badwords=$(paste -s -d '|' $badfile)

echo searching for banned keywords!
grep --only-matching -P '^.*?(?=(\-\-|$))' src/* | grep --color -P '\b('$badwords')\b'
