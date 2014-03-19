#!/bin/bash

# M1: logout curent user
/usr/bin/gnome-session-quit --no-prompt

# M2: logout user by username
pkill -KILL -u `logname`
pkill -KILL -u `whoami`

# Kill and Logout All Users
pkill -KILL -v /dev/pts/*
