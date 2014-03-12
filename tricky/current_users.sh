#!/bin/bash

# M1: show all logged on users
who
# Show current logged on users
# Passing any two arguments to who is the equivalent of
# who -m, as in who am i or who The Man
who -m
# Only show current user name
whoami

# M2: show all logged on users and processes belonging to them
w
w | grep ryan

# M3: show current logged on users name
logname
# show name of the user attached to the current process
whoami
