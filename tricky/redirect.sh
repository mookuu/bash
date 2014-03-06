#!/bin/bash

# M1: 输入重定向(Redirecting Input)
format:
    fd<file                 # fd: file descriptor
description:
    redirect fd to file（open as read）.If fd is ignored, it is "Redirecting Standard Input".
sample:
    cat < file
    cat 0< file

# M2: 输出重定向(Redirecting Output)
format:
    fd > file
    fd >| file                   # [1]
Option:
    noclobber --> avoid file\'s overwritten, default OFF
        Open:  set -o noclobber # file cannot be overwriten unless force redirection[1]
        Close: set +o noclobber # file can be overwriten:default
description:
    redirect fd to file（open as write）. If fd is ignored, it is "Redirecting Standard Output"

sample:
    set -o noclobber
    touch file
    ls > file
    ls 1> file                                 # same as upper sentence
    bash: file: cannot overwrite existing file # Error
    ls >| file                                 # force redirection
    cat file

Apply: add noclobber to .bashrc
echo 'set -o noclobber' >> ~/.bashrc # avoid file overwrite by mistake, use | if necessary

# M3: 附加输出重定向(Appending Redirected Output)
format:
    fd >> file
description:
    same as Redirecting Output,
