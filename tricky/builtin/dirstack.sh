#!/bin/bash

# The top value in the directory stack [1] (affected by pushd and popd)
# This builtin variable corresponds to the dirs command, however dirs shows
# the entire contents of the directory stack.
#
echo $DIRSTACK
