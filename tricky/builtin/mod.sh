#!/bin/bash

#
# Change file's privilege automatically
#

# regular files
[ -f $1 ] && sudo chmod 755 $1 && exit 0

# directory
[ -d $1 ] && sudo chmod -R 755 && exit 0

echo "Unknown error."

exit
