#!/bin/bash

# 将ls的结果保存到变量CUR_DIR中
CUR_DIR=`ls`

# 显示ls的结果
echo $CUR_DIR

# M1:
for val in $CUR_DIR
do
	# 若val是文件，则输出该文件名
	if [ -f $val ];then
		echo "FILE: $val"
	fi
done


# M2: C format
sum=0
for ((i=1;i<10;i++))
do
	((sum=$sum+$i))
done
echo "sum=$sum"


# M3: Seq command
for k in $( seq 1 10 )
do
	mkdir ./aaa${k}
	cd aaa${k}
	for l in $( seq 1 10 )
	do
		mkdir bbb${l}
	done
	cd ..
done


exit 0
