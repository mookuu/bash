#!/bin/bash

UNPACK=1
echo $UNPACK
if [ ${1##*.} = bz2 ] ; then
        TEMP=${1%.*}
        if [ ${TEMP##*.} = tar ] ; then
                tar jxvf $1
                UNPACK=$?
                echo This is a tar.bz2 package
        else
                bunzip2 $1
                UNPACK=$?
                echo This is a bz2 package
        fi
fi

if [ ${1##*.} = gz ] ; then
        TEMP=${1%.*}
        if [ ${TEMP##*.} = tar ] ; then
                tar zxvf $1
                UNPACK=$?
                echo This is a tar.gz package
        else
                gunzip $1
                UNPACK=$?
                echo This is a gz package
        fi
fi

if [ ${1##*.} = tar ] ; then
        tar xvf $1
        UNPACK=$?
        echo This is a tar package
fi

if [ $UNPACK = 0 ] ; then
        echo Success!
else
        echo Maybe it is not a package or the package is damaged?
fi
