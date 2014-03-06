#! /bin/bash
 #这是一个用递归函数写的阶乘的例子,
 function factorial
 {
 ret_val=0
 factarg=0
 if (( $1<=1 ))
 then
 res=1
 return 0
 else
 (( factarg=$1 - 1 ))
 factorial $factarg
 (( ret_val=$1 * $res ))
 res=$ret_val
 return 0
 fi
 }
 factorial $1
 echo "Factorial of $1 is:$res"
