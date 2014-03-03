#!/bin/bash

# ★★★★★★★★★★★★★★★★★★★★★★ #
# Referenced: http://www.linuxsir.org/  #
# by RyanH@osk 2014-3-3                 #
# Email: otagao@gmail.com               #
# ★★★★★★★★★★★★★★★★★★★★★★ #

# TRANSFER UNIX TIMESTAMP TO DATE
# Usage:
# 1: ./tm2date.sh timestamp
# 2: echo timestamp | ./tm2date.sh

# script start
LANG=C                          # TODO: ???

if [ -z $1 ]; then
        if [ -p /dev/stdin ]; then # ipnut from a pipe
                read -r p
        else
                echo "No timestam given." >&2
                exit
        fi
else
        p=$1
fi

date -d @$p +%c
# script end
