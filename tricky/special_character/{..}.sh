#!/bin/bash
# Extended expression

echo {a..z}
# a b c d ... x y z

echo {0..3}
# 0 1 2 3

#
base64_charset=( {A..Z} {a..z} {0..9} + / = )
# Initializing an array, using extended brace expansion.
# From vladz's "base64.sh" example script.

echo ${base64_charset[1]}


# default-parameter
var1=	# set to null
var2=2
# var3 is unset.
echo ${var1-$var2}	# null(stronger,)
echo ${var1-:$var2}	# 2
echo ${var3-$var2}	# 2
#
# 1
# 2
Note the $ prefix.
echo ${username-`whoami`}
# Echoes the result of `whoami`, if variable $username is still unset.
# ${parameter-default} and ${parameter:-default} are almost
# equivalent. The extra : makes a difference only when parameter has been declared,
# but is null.

