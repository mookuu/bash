#!/bin/bash

# ★★★★★★★★★★★★★★★★★★★★ #
# M1: !$
# get last parameter of last command
# eg: mkdir gemini/dir_test
#     cd !$ <==> cd gemini/dir_test
# effect in command line
# ★★★★★★★★★★★★★★★★★★★★ #

# ★★★★★★★★★★★★★★★★★★★★ #
# M2: ll
# alias ll='ls -alF'
#       -F, --classify
#              append indicator (one of */=>@|) to entries
# *: executable file
# /: directory
# =: socket file
# >: TODO
# @: link file
# |: FIFO file
# add nothing: regular file
# ★★★★★★★★★★★★★★★★★★★★ #

# clear file's contents
command < file > file
