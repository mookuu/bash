#!/bin/bash

# fill file with zero, if file not exists, create it

: > tmpfile.txt

# same as
cat /dev/null > tmpfile.txt
cat /dev/zero > tmpfile.txt
