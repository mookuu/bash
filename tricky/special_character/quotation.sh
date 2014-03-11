#!/bin/bash

# full quote
ls -l [Vv]*                     # file contains v or V character
ls -l '[Vv]*'                   # file contains Vv*(whoes name is Vv*)

# Special
bash$ grep '[Ff]irst' *.txt
file1.txt:This is the first line of file1.txt.
file2.txt:This is the First line of file2.txt.


# discard newlines
echo $(ls -l)

# partial quote: reserve newlines
echo "$(ls -l)"
