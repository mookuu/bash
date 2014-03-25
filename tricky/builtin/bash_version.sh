#!/bin/bash

#
# 6-element array of version information
#
for n in 0 1 2 3 4 5
do
  echo "BASH_VERSINFO[$n] = ${BASH_VERSINFO[$n]}"
done



#BASH_VERSINFO[0] = 4				# Major version no.
#BASH_VERSINFO[1] = 2				# Minor version no.
#BASH_VERSINFO[2] = 37				# Patch level.
#BASH_VERSINFO[3] = 1				# Build version.
#BASH_VERSINFO[4] = release			# Release status.
#BASH_VERSINFO[5] = x86_64-pc-linux-gnu		# Architecture
						# (same as $MACHTYPE).
# Chk current shell
echo $BASH_VERSION
echo $SHELL		# may ouput nothing on some shell
bash -version
