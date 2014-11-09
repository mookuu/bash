#!/bin/bash
# {,} brace expression
# get all the elements in {} and execute opposite action(with comma)
# Recursive

# M1: concatenate strings
echo \"{a,b,c}\"	# replace comma-separated strings with space
# "a" "b" "c"
echo \"{a b c}\"	# nothing changed
# "{a b c}"

# M2: concatenate files
cat {file1,file2,file3} > combined_file

# M3: for backup
cp file1.{txt,backup}

# M4:
for file in /{,usr/}bin/*calc
#	      ↑ same as {space,usr}
do
	:
done

# M5: recursive
# No spaces allowed within the braces unless the spaces are quoted or escaped.
echo {file1,file2}\ :{\ A," B",' C'}
# file1 : A file1 : B file1 : C file2 : A file2 : B file2 :C


