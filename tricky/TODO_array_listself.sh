#!/bin/bash -u

file_contents=( $(cat -A "$0") )

echo $((${#file_contents[@]} - 1))
for element in $(seq 0 $((${#file_contents[@]} - 1)))
do
        echo -n "${file_contents[$element]//\$/}"
done
