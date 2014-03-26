#!/bin/bash

#
# eval cmmand-line
# scan the sentence twice before execute the shell

# M1:
# First replace $pipe with |
# Second 
pipe="|"
eval ls $pipe wc -l


# M2:
# First get rid of \
# Second replace $# with numbers of parameter 
eval echo \$$#

# M3: pointer
x=100
ptrx=x
eval echo \$$ptrx	#指向ptrx，用这里的方法可以理解b中的例子
eval $ptrx=50		#将50存到ptrx指向的变量中。
echo $x
