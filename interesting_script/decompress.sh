#!/bin/bash -x

# ----------------------------------------
# | Referenced: http://www.linuxsir.org/ |
# | by RyanH@osk 2014-3-1                |
# | Email: otagao@gmail.com              |
# ----------------------------------------

# TODO: structure optimization
#       if->elif->elif->else->fi
# TODO: authority(mkdir -> directory)

#
# Update:
#	decompress directory added by @2014-04-15 by H

# Following packages are supported.
# .tar | .bz | .tar.bz | .bz2 | .tar.bz2 | .gz | .tar.gz
# .tgz | .zip | .rar | .Z | .tar.Z | .lha | .xz

# TODO: `pwd` add
# decompress /home/Downloads/test.gzip

UNPACK=1                        # rtn: [OK:0] [NG:1]
E_DIRWRONG=85

# compressed file's directory
# CUR_DIR=`pwd`

# .tar package
if [ ${1##*.} == tar ]; then
	[ -d ${1%%.tar} ] || sudo mkdir ${1%%.tar}
	sudo cp $1 $_ && cd $_
        tar xvf $1 && sudo rm $1
        #tar cvf $1                  # make package
        UNPACK=$?
        echo This is a tar package.
fi

# .bz || .tar.bz package
if [ ${1##*.} == bz ]; then
        TMP=${1%.*}
        if [ ${TMP##*.} == tar ]; then
		[ -d ${1%%.tar.bz} ] || sudo mkdir ${1%%.tar.bz}
		sudo cp $1 $_ && cd $_
                tar jxvf $1 && sudo rm $1     # uncompress package
                UNPACK=$?
                echo This is a tar.bz package.
        else
		[ -d ${1%%.bz} ] || sudo mkdir ${1%%.bz}
		sudo cp $1 $_ && cd $_
                bunzip2 $1 && sudo rm $1
                # bzip -d $1      # M2
                UNPACK=$?
                echo This is a bz package.
        fi
fi


# .bz2 || .tar.bz2 package
if [ ${1##*.} == bz2 ]; then
        TMP=${1%.*}
        if [ ${TMP##*.} == tar ]; then
		[ -d ${1%%.tar.bz2} ] || sudo mkdir ${1%%.tar.bz2}
		sudo cp $1 $_ && cd $_
                tar jxvf $1 && sudo rm $1     # uncompress package
                # tar jcvf test.tar.bz2 ${1%%.*} # compress package
                UNPACK=$?       # get last code's result
                echo This is a tar.bz2 package.
        else
		[ -d ${1%%.bz2} ] || sudo mkdir ${1%%.bz2}
		sudo cp $1 $_ && cd $_
                bunzip2 $1 && sudo rm $1
                # bzip -d $1      # M2
                UNPACK=$?
                echo This is a bz2 package.
        fi
fi

# .gz || .tar.gz package
if [ ${1##*.} == gz ]; then
        TMP=${1%.*}
        if [ ${TMP##*.} == tar ]; then
		[ -d ${1%%.tar.gz} ] || sudo mkdir ${1%%.tar.gz}
		sudo cp $1 ${1%%.tar.gz} && cd $_
                tar zxvf $1 && sudo rm $1
                # tar zxvf $1 -C ./test # decompress to specify folder
                # tar zcvf test.tar.gz ${1%%.*} # compress package
                UNPACK=$?
                echo This is a tar.gz package.
        else
		[ -d ${1%%.gz} ] || sudo mkdir ${1%%.gz}
		sudo cp $1 ${1%%.gz} && cd $_
                gunzip -f *.gz && tmp=$_
		# remove tmporary compressed file
		if [ -e  $tmp ]; then
			sudo rm $tmp
		fi
                # gzip -d $1
                # gzip ${1} # compress package
                UNPACK=$?
                echo This is a gz package.
        fi
fi

# .tgz package
if [ ${1##*.} == tgz ]; then
	[ -d ${1%%.tgz} ] || sudo mkdir ${1%%.tgz}
	sudo cp $1 $_ && cd $_
        tar zxvf $1 && sudo sudo rm $1
        # tar zxvf $1 -C ./test # decompress to specify folder
        # tar zcvf test.tgz ${1%%.*} # compress package
        UNPACK=$?
        echo This is a tgz package.
fi

# .zip package
if [ ${1##*.} == zip ]; then
	# if necessary?
	[-d ${1%%.zip} ] || sudo mkdir ${1%%.zip}
        sudo unzip $1 -d ${1%%.zip}
        # zip test.zip ${1}
        UNPACK=$?
        echo This is a zip package.
fi

# .rar package
if [ ${1##*.} == rar ]; then
        # Filename
        if [ -d "${1%%.rar}" ]; then
                echo "Directory exists, overwriten?"
                echo "errno: $E_DIRWRONG" && exit "$E_DIRWRONG"
        else
                sudo mkdir ${1%%.rar} && sudo cp "$1" "$_" && cd "$_"
        fi
        sudo rar x "${1##*\/}" && sudo rm "$_" && cd -
        # rar a test.zip ${1}
        UNPACK=$?
        echo This is a rar package.
fi

# .Z | .tar.Z  package
if [ ${1##*.} == Z ]; then
        TMP=${1%.*}
        if [ ${TMP##*.} == tar ]; then
		[ -d ${1%%.tar.Z} ] || mkdir ${1%%.tar.Z}
		cp $1 $_ && cd $_
                tar Zxvf $1 && rm $1
                # tar Zcvf FileName.tar.Z DirName # compress
                UNPACK=$?
                echo This is a tar.Z package.
        else
		[ -d ${1%%.Z} ] || mkdir ${1%%.Z}
		cp $1 $_ && cd _
                uncompress $1 && rm $1
                # compress directory_name # compress
                UNPACK=$?
                echo This is a .Z package.
        fi
fi

# .lha package
if [ ${1##*.} == lha ]; then
	[ -d ${1%%.lha} ] || mkdir ${1%%.lha}
	cp $1 $_ && cd $_
        lha -e $1 && rm $1
        # lha -a FileName.lha FileName # compress
        UNPACK=$?
        echo This is a lha package.
fi

# .xz package
if [ ${1##*.} == xz ]; then
        xz -d $1
        tar -xvf ${1%.*}
        UNPACK=$?
        echo This is a xz package.
fi

# rtn check
if [ $UNPACK == 0 ]; then
        echo "Succes!"
else
        echo "Failed!"
	echo "Please check if you have the permissions."
        echo "Or maybe it is not a package or the package is broken?"
fi
