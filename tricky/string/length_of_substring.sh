#!/bin/bash 

string=abcABC123ABCabc

# M1:
echo M1
echo Using '`expr match "$string" '\''$substring'\''`'
echo Len1: [`expr match "$string" 'abc[A-Z]*.2'`]
echo

# M2:
echo M2
echo Using '`expr "$string" : '\''$substring'\''`'
echo Len1: [`expr "$string" : 'abc[A-Z]*.2' `]
echo
