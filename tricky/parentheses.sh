#!/bin/bash

# command group
# A listing of commands within parentheses starts a subshell.
# local scope
a=2
(a=3;)

echo $a # a=2
# "a" within parentheses acts like a local variable.

# A listing of commands within parentheses starts a subshell.
while :
do
        echo $$
        (while :;do echo $$; done)
#        echo $$

done

# however, the curl bracket won't
a=123
{ a=321; }
echo "a = $a"
# a = 321
# (value inside code block)

