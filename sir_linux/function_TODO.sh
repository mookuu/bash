$cat dbfunctions
addon () {                  # 定义函数addon,他的功能是把新的信息加入datafile
    while true
    do
        echo "Adding information "
        echo "Type the full name of employee "
        read name
        echo "Type address for employee "
        read address
        echo "Type start date for employee (4/10/88 ) :"
        read startdate
        echo $name:$address:$startdate
        echo -n "Is this correct? "
        read ans
        case "$ans"  in
        [Yy]*)
            echo "Adding info..."
            echo $name:$address:$startdate>>datafile
            sort -u datafile -o datafile
            echo -n "Do you want to go back to the main menu? "
            read ans
            if [ $ans = Y -o $ans = y ]
            then
                return        # return命令把控制送回函数被调用时所在的调用程序
             else
                continue        # 把控制返回到while循环顶部
            fi
                ;;
        *)
            echo "Do you want to try again? "
            read answer
            case "$answer" in
                [Yy]*)
                    continue;;
                *)
                    exit;;
            esac
                ;;
        esac
    done
}       # 结束函数定义

$cat mainprog
#!/bin/sh
script name: mainprog
# This is the main script that will call the function, addon

#datafile=$HOME/bourne/datafile
datafile=./datafile

.  dbfunctions  # dot命令把文件dbfunctions装入内存,

if [ ! -f $datafile ]
then
    echo "`basename $datafile` does not exist" 1>&2
    exit 1
fi
echo "Select one: "
cat <<EOF
    [1] Add info
    [2] Delete info
    [3] Exit
EOF
read choice
case $choice in
    1)  addon   # 调用函数
        ;;
    2)  delete  # 调用函数
        ;;
    3)  update
        ;;
    4)  echo Bye
        exit 0
        ;;
    *)  echo Bad choice
        exit 2
        ;;
esac
echo Returned from function call
echo The name is $name
# Variable set in the function are known in this shell.

附:文件datafile
cat database
Ann Stephens            111 Main St, Boston, MA         4/10/88
TB Savage               222 B Ave, New York, NY         5/11/99
