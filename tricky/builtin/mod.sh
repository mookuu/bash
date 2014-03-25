#!/bin/bash

#
# Change file's privilege automatically
#

# null parameter
[ -z $1 ] && echo "null parameter" && exit 0

# regular files
[ -f $1 ] && sudo chmod 755 $1 && exit 0

# directory
[ -d $1 ] && sudo chmod -R 755 $1 && exit 0

echo "Unknown error."

exit
