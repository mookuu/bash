#!/bin/bash

foo()
{
local i=0
local total=$#
echo "total parameter: $total"

for val in $@
do
    ((i++))
    echo "argument[$i] --> val=$val"
done

return $total
}

# call function foo() without passing parameter
foo
echo "return value:$?"

# pass 2 parameters
foo 2 4
echo "return value:$?"

exit 0
