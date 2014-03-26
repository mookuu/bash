#!/bin/bash

# 将ls的结果保存到变量CUR_DIR中
CUR_DIR=`ls`

# 显示ls的结果
echo $CUR_DIR

for val in $CUR_DIR
do
# 若val是文件，则输出该文件名
if [ -f $val ];then
echo "FILE: $val"
fi 
done

exit 0
