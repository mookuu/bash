#!/bin/bash -x


awk '{print substr($1,1,3)}' example3.txt

awk '{printf "mv %s %s/%s\n", $1, substr($1,1,3), substr($1,4,2)}' example3.txt
