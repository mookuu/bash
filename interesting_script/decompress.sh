#!/bin/bash

# ----------------------------------------
# | Reference: http://www.linuxsir.org/  |
# | by RyanH@osk 2014-3-1                |
# | Email: otagao@gmail.com              |
# ----------------------------------------

#
# Update:
#	decompress directory added @2014-04-15 by H
#       structure optimize @2014-04-29 by H

# Following packages are supported.
# .bz (.bz|.tar.bz)
# .bz2(.bz2|.tar.bz2)  -> .tar.bz2 test OK
# .gz (.gz|.tar.gz)    -> test OK
# .tar
# .tgz
# .rar
# .zip
# .Z   | .tar.Z
# .lha
# .xz

# TODO: sometime package delete original package after decompress
# TODO: directory alread exists, overriten?
# decompress /home/Downloads/test.gzip

UNPACK=1                        # rtn: [OK:0] [NG:1]
E_DIRWRONG=85

# compressed file's directory
# CUR_DIR=`pwd`

# directory create
dir_create()
{
        # directory not exists
        if [ ! -d $1 ]; then
                if [ -w . ]; then
         	       # owner of new directory is current user
         	       mkdir $1
                else
         	       sudo mkdir $1
         	       sudo chown -R `logname`:`logname` $1
                fi
        else
                # if permission denied
                if [ ! -w $1 ]; then
                        sudo chmod o+w $1
                fi
        fi
}

# check if destination directory contains subdirectory whose name is same with current directory
# sample: test_dir/test_dir/*
dir_check()
{
        if [ -d $1 ]; then
                mv $1/* . && rm -fr $1
        fi
}

# .bz || .tar.bz package
bz_func()
{
        if [ ${1##*.} == bz ]; then
                TMP=${1%.*}
                if [ ${TMP##*.} == tar ]; then
                        dec_dir=${1%.tar.bz}
                        # directory create
                        dir_create $dec_dir
                        cp $1 $dec_dir && cd $_
                        tar jxvf $1     # uncompress package
                        UNPACK=$? && rm $1
                        # directory check
                        dir_check $dec_dir
                        echo This is a tar.bz package.
                else
                        dec_dir=${1%.bz}
                        # directory create
                        dir_create $dec_dir
                	cp $1 $dec_dir && cd $_
                        bunzip2 $1
                        UNPACK=$? && rm $1
                        # directory check
                        dir_check $dec_dir
                        # bzip -d $1      # M2
                        echo This is a bz package.
                fi
        fi
}

# .bz2 || .tar.bz2 package
bz2_func()
{
        if [ ${1##*.} == bz2 ]; then
                TMP=${1%.*}
                if [ ${TMP##*.} == tar ]; then
                        dec_dir=${1%.tar.bz2}
                        # in case of permission denied
                        dir_create $dec_dir
                        cp $1 $dec_dir && cd $_
                	tar jxvf $1     # uncompress package
                        # tar jcvf test.tar.bz2 ${1%%.*} # compress package
                        UNPACK=$? && rm $1           # get last code's result
                        dir_check $dec_dir
                        echo This is a tar.bz2 package.
                else
                        dec_dir=${1%.bz2}
                        dir_create $dec_dir
                	cp $1 $dec_dir && cd $_
                        bunzip2 $1
                        # bzip -d $1      # M2
                        UNPACK=$? && rm $1
                        dir_check $dec_dir
                        echo This is a bz2 package.
                fi
        fi
}

# .gz || .tar.gz package
gz_func()
{
        if [ ${1##*.} == gz ]; then
                TMP=${1%.*}
                if [ ${TMP##*.} == tar ]; then
                        dec_dir=${1%.tar.gz}
                        # in case of permission denied
                        dir_create $dec_dir
                	cp $1 $dec_dir && cd $_
                        tar zxvf $1
                        # tar zxvf $1 -C ./test # decompress to specify folder
                        # tar zcvf test.tar.gz ${1%%.*} # compress package
                        UNPACK=$? && rm $1
                        dir_check $dec_dir
                        echo This is a tar.gz package.
                else
                        dec_dir=${1%.gz}
                        dir_create $dec_dir
                	cp $1 $dec_dir && cd $_
                        gunzip -f $1
                        UNPACK=$?    # delete original package by default
                        # gzip -d $1
                        # gzip ${1} # compress package
                        dir_check $dec_dir
                        echo This is a gz package.
                fi
        fi
}

# .tar package
tar_func()
{
        if [ ${1##*.} == tar ]; then
                dec_dir=${1%.tar}
                dir_create $dec_dir
                cp $1 $dec_dir && cd $_
                tar xvf $1
                #tar cvf $1                  # make package
                UNPACK=$? && rm $1
                dir_check $dec_dir
                echo This is a tar package.
        fi
}

# .zip package
if [ x${1##*.} == xzip ]; then
	# if necessary?
	[-d ${1%%.zip} ] || sudo mkdir ${1%%.zip}
        sudo unzip $1 -d ${1%%.zip}
        # zip test.zip ${1}
        UNPACK=$?
        echo This is a zip package.
fi

# .tgz package
tgz_func()
{
        if [ ${1##*.} == tgz ]; then
                dec_dir=${1%.tgz}
                dir_create $dec_dir
                cp $1 $dec_dir && cd $_
                tar zxvf $1
                # tar zxvf $1 -C ./test # decompress to specify folder
                # tar zcvf test.tgz ${1%%.*} # compress package
                UNPACK=$? && rm $1
                dir_check $dec_dir
                echo This is a tgz package.
        fi
}

# .rar package
rar_func()
{
        if [ ${1##*.} == rar ]; then
                dec_dir=${1%.rar}
                dir_create $dec_dir
                cp $1 $dec_dir && cd $_
                # sudo rar x "${1##*\/}" && sudo rm "$_" && cd -
                rar x $dec_dir
                # rar a test.zip ${1}
                UNPACK=$? && rm $1
                dir_check $dec_dir
                echo This is a rar package.
        fi
}

# .zip package
zip_func()
{
        if [ ${1##*.} == zip ]; then
                dec_dir=${1%.zip}
                dir_create $dec_dir
                unzip $1 -d $dec_dir
                # zip test.zip ${1}
                UNPACK=$?
                dir_check $dec_dir
                echo This is a zip package.
        fi
}

# .Z | .tar.Z  package
zZ_func()
{
        if [ ${1##*.} == Z ]; then
                TMP=${1%.*}
                if [ ${TMP##*.} == tar ]; then
                        dec_dir=${1%.tar.z}
                        dir_create $dec_dir
                	cp $1 $dec_dir && cd $_
                        tar Zxvf $1
                        # tar Zcvf FileName.tar.Z DirName # compress
                        UNPACK=$? && rm $1
                        dir_check $dec_dir
                        echo This is a tar.Z package.
                else
                        dec_dir=${1%.Z}
                        dir_create $dec_dir
                	cp $1 $dec_dir && cd _
                        uncompress $1
                        # compress directory_name # compress
                        UNPACK=$? && rm $1
                        dir_check $dec_dir
                        echo This is a .Z package.
                fi
        fi
}

# .lha package
lha_func()
{
        if [ ${1##*.} == lha ]; then
                dec_dir=${1%.lha}
                dir_create $dec_dir
                cp $1 $dec_dir && cd $_
                lha -e $1
                # lha -a FileName.lha FileName # compress
                UNPACK=$? && rm $1
                dir_check $dec_dir
                echo This is a lha package.
        fi
}

# .xz package
xz_func()
{
        if [ ${1##*.} == xz ]; then
                # generally .tar.xz package
                dec_dir=${1%.tar.xz}
                dir_create $dec_dir
                xz -d $1
                cp ${1%.xz} $dec_dir && cd $_
                tar -xvf ${1%.xz}
                UNPACK=$?
                dir_check $dec_dir
                echo This is a xz package.
        fi
}

# Function entry
main()
{
        case ${1##*.} in
                bz)
                        bz_func $1
                        ;;
                bz2)
                        bz2_func $1
                        ;;
                gz)
                        gz_func $1
                        ;;
                tar)
                        tar_func $1
                        ;;
                tgz)
                        tgz_func $1
                        ;;
                rar)
                        rar_func $1
                        ;;
                zip)
                        zip_func $1
                        ;;
                z|Z)
                        zZ_func $1
                        ;;
                lha)
                        lha_func $1
                        ;;
                xz)
                        xz_func $1
                        ;;
        esac
}

if [ x$1 == x ]; then
	echo "Usage: decompress compressed_file"
	exit
fi
main $1
# rtn check
if [ $UNPACK == 0 ]; then
        echo "Succes!"
else
        echo "Failed!"
	echo "Please check the following possibility:"
        echo "   Package broken."
        echo "   Permissions denied."
fi
