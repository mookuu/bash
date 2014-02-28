#!/bin/bash

# following is sample

echo "★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★"
var="hello world!"

echo "var: $var"

num="2"
echo "this is the ${num}nd test!"

# [] case test
echo "★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★"
if [ "$SHELL" = "/bin/bash" ]; then
    echo "your login shell is the bash (bourne again shell)"
else
    echo "your login shell is not bash but $SHELL"
fi

# &&: same as logic and in C language
echo "logic and in bash"
[ -f "/etc/shadow" ] && echo "This computer uses shadow passwords"

# ||: same as logic or in C language
[ -f "/etc/shadow/aa" ] || echo "logic or in bash"

#
echo "★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★"
mailfolder=/var/mail/james
if [ -r "$mailfolder" ]; then
    echo "$mailfolder has mail from:"
    grep "From" $mailfolder > //home/gemini/workspace/cs/bash/bash-master/tmp/mail_add.txt
else
    { echo "Can not read $mailfolder" ; exit 1; }
fi

# file uncompressed
echo "★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★"
echo "file uncompressed>"
ftype=`file "$1"`
case "$ftype" in
"$1: Zip archive"*)
　　unzip "$1" ;;
"$1: gzip compressed"*)
　　gunzip "$1" ;;
"$1: bzip2 compressed"*)
　　bunzip2 "$1" ;;
*) error "File $1 can not be uncompressed with smartzip";;
esac

# selcect
echo "★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★"
echo "What is your favourite OS?"
select var in "Linux" "Gnu Hurd" "Free BSD" "Other"; do
    break;
done
echo "You have selected: $var"

# for
echo "★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★"
for var in A B C ; do
    echo "var is $var"
done

# list a content summary of a number of RPM packages
# USAGE: showrpm rpmfile1 rpmfile2 ...
# EXAMPLE: showrpm /cdrom/RedHat/RPMS/*.rpm
echo "★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★"
for rpmpackage in $*; do
    if [ -r "$rpmpackage" ];then
        echo "=============== $rpmpackage =============="
        rpm -qi -p $rpmpackage
    else
        echo "ERROR: cannot read file $rpmpackage"
    fi
done

# wildcard characters expand
echo "★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★"
echo $SHELL
echo "$SHELL"
echo '$SHELL'

echo $\SHELL
echo "$\SHELL"


echo "★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★"
