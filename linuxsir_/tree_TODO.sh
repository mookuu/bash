#!/bin/sh
#
# tree.sh
# A tool that display the dictionary structure in dos's
# tree command style.
# By Matthew <matthew@linuxforum.net>
#
#    __@
#  _ \<_
# (_)/(_)
# Apr 29 2003
#
# Tested on slackware, openbsd, netbsd, freebsd.
#
# Just for fun.
#

# The name of the ls program, please use
# the absolute path, otherwise, there
# may be get some strange errors.
#
LSPROG="/bin/ls"

# COLOR DEFINE
# ============
#
DIR="\033[01;34m"
EXE="\033[01;32m"
DEV="\033[01;33m"
LNK="\033[01;36m"
ZIP="\033[01;31m"
SOCK="\033[01;35m"
NULL="\033[00m"

ROOT=${1:-.}
TRUE=0
FALSE=1
LAYERS=0
FILECOUNT=0
DIRCOUNT=0

# print_dash
# ==========
# Print the structure lines
#
print_dash()
{
        local i=0
        local num=$1

        while [ $i -lt $num ]; do
                echo -n "|"
                for j in 1 2 3; do
                        echo -n " "
                done

                i=`expr $i + 1`
        done

        echo -n "|-- "
}

# ispkg
# =====
# Test if the file is a package like:
# .gz .tar .tgz .tar.gz .zip .rar .rpm
# and etc.
#
ispkg()
{
        local f=$1
        local i

        # Package extension list, you can add your coustom
        # extensions in it.
        #
        local pkg__ext=".gz .tar .tgz .tar.gz .zip .rar .rpm"

        # if the file's suffix contain any package extension
        # then cut it.

        for i in $pkg__ext; do
                f=${f%$i}
        done

        if [ "$f" != "$1" ]; then
                return $TRUE
        else
                return $FALSE
        fi
}

# mktree
# ======
# The main function, that print the
# dictionary structure in dos's tree
# command style. It's runs in nesting.
#
mktree()
{
        local f
        for f in `$LSPROG -1 $1 2> /dev/null`; do
                f=${f%/}
                f=${f##*/}

                # If dictionary then print it and enter
                # the nesting block.
                if [ -d $1/$f ]; then
                        print_dash $LAYERS
                        echo -e "${DIR}$f${NULL}"
                        DIRCOUNT=`expr $DIRCOUNT + 1`

                        LAYERS=`expr $LAYERS + 1`
                        mktree $1/$f
                else
                        print_dash $LAYERS
                        # file is a symbol link
                        if [ -L $1/$f ]; then
                                echo -e "${LNK}$f${NULL}"
                        # file is executable
                        elif [ -x $1/$f ]; then
                                echo -e "${EXE}$f${NULL}"
                        # file is a device
                        elif [ -c $1/$f -o -b $1/$f ]; then
                                echo -e "${DEV}$f${NULL}"
                        # file is a socket
                        elif [ -S $1/$f ]; then
                                echo -e "${SOCK}$f${NULL}"
                        # file is a package
                        elif `ispkg $f`; then
                                echo -e "${ZIP}$f${NULL}"
                        else
                                echo -e "$f"
                        fi

                        FILECOUNT=`expr $FILECOUNT + 1`
                fi
        done

        LAYERS=`expr $LAYERS - 1`
}

echo $ROOT
mktree $ROOT
echo "\`"
echo "$DIRCOUNT directories, $FILECOUNT files"
