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
    same as Redirecting Output, except contents are expended to the file

# M4:标准输出与标准错误输出重定向（Redirecting Standard Output and Standard Error）
format:
    &>file                      # alse '>&file'
    >file2&1                    # same as upper two
description:
    redirect standard output to file（open as write）

explantion:
    >file2&1
    1: redirect standard output to word, now standard output point to file(output to file)
    2: copy standard error to standard output(now point to file, so copy error to file)
sample:
    date &> file
    cat file                    # show file contents
    date &> file                # overwrite
    cat file                    # show file contents
    date &>> file               # append to file
    cat file                    # show file contents
    mkdir &>> file              # missing parameter, error happed
    cat file                    # show file contents

# M5:附加标准输出与标准错误输出重定向（Appending Standard Output and Standard Error）
format:
    &>>file
    >>file2&1
description:
    same as &>file excpt append to the end of file

# M6:复制文件描述符（Duplicating File Descriptors）
format:
    fd<&files_fd                # files_fd shoubld be number
    fd>&files_fd                # TODO: same as copy fd(contents) to files_fd
description:
    if fd is ignored, same as >&file

# M7:移动文件描述符（Moving File Descriptors）
format:
    fd<&files_fd-
    fd>&files_fd-
description:
    same as M6 excpet fd will be closed after move

# M8:读写打开文件描述符（Opening File Descriptors for Reading and Writing）
format:
    fd<>file
description:
    read fd(contents) to file(as read and write). If fd is ignored, standard
    input is set.
sample:
    exec 3<>file                # redirect fd(3) to file
    ls &>3                      # redirect stdout(1) to 3(now file) and write ls to file
    cat file                    # cut off link between fd(3) and file, exec exist in one cmd
    cat <&3                     # now fd(3) links nothing, NULL to display(stdin)
    exec 3<>file                # link again
    cat <&3                     # contents exist

# M9: Here文件（Here Documents）
format:
    <<[-]delimiter
    here-document
    delimiter
description:
    read contents between delimiter and pass to stdin, - can get rid of tab
    before each line.
    If delimiter is covered by " ", then extension is forbidden.
sample:
cat <<EOF
$(pwd)             # 指令替换
`pwd`              # 指令替换的第2种形式
$HOME              # 参数扩展
$((4+5))           # 算数扩展
EOF
result:
/home/leo            # extension OK
/home/leo            # extension OK
/home/leo            # extension OK
9                    # extension OK
cat <<"EOF"
$(ls)
`pwd`
$HOME
$((4+5))
EOF
result:
$(ls)               # extionsion NG
`pwd`               # extionsion NG
$HOME               # extionsion NG
$((4+5))            # extionsion NG

# M10: Here字符串（Here Strings）
format:
    <<<file
description:
    pass contents of file(after extension) as stdoin to command
sample:
    echo 'something' |command
    command <<<'something'
