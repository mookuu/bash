#!/bin/awk -f   # 当文件有可执行权限的时候你可以直接执行
                # ./script1.awk example2.txt
                # 如果没有以上这行可能会出现错误，或者
                # awk -f script1.awk example2.txt 参数f指脚本文件

BEGIN {         # “BEGIN{”是awk脚本开始的地方
    FS=":";     # FS 是在awk里指分割符的意思
}

{                                # 接下来的“{” 是内容部分
      print "add {";             # 以下都是使用了一个awk函数print
      print "uid=" $1;
      print "userPassword=" $2;
      print "domain=eyou.com" ;
      print "bookmark=1";
      print "voicemail=1";
      print "securemail=1"
      print "storage=" $5;
      print "}";
      print ".";
}                               # “}”    内容部分结束
END {                           # “END{” 结束部分
    print "exit";
}

# awk -F: '{print $1"@"$2}' example2.txt
# awk -F: '{printf "%s@%s\n",$1,$2}' example2.txt
