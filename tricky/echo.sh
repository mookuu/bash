#!/bin/bash

bash$ echo hello\!
hello!
bash$ echo "hello\!"
hello\!


bash$ echo \
>
bash$ echo "\"
>
bash$ echo \a
a
bash$ echo "\a"
\a


bash$ echo x\ty
xty
bash$ echo "x\ty"
x\ty

bash$ echo -e x\ty
xty
bash$ echo -e "x\ty"
x       y

echo -e 处理特殊字符

若字符串中出现以下字符，则特别加以处理，而不会将它当成一般文字输出：
\  backslash escape
   default: output the character after \
   echo -e "\a"                                        # bell
     -e     enable interpretation of backslash escapes # 允许转义

\a 发出警告声；
\b 删除前一个字符；
\c 最后不加上换行符号；
\f 换行但光标仍旧停留在原来的位置；
\n 换行且光标移至行首；
\r 光标移至行首，但不换行；
\t 插入tab；
\v 与\f相同；
\\ 插入\字符；
\nnn 插入nnn（八进制）所代表的ASCII字符；

$echo -e "a\bdddd"
dddd

$echo -e "a\adddd" //输出同时会发出报警声音
adddd


$echo -e "a\ndddd" //自动换行
a
dddd
