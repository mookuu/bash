#!/bin/bash

echo "The # here does not begin a comment."
echo 'The # here does not begin a comment.'
echo The \# here does not begin a comment.
echo The # here begins a comment.
echo ${PATH#*:} # Parameter substitution, not a comment.
echo $(( 2#101011 )) # Base conversion, not a comment.
echo "Github test"

# Thanks, S.C.
