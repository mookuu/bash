#!/bin/awk -f   # 当文件有可执行权限的时候你可以直接执行
                # ./script1.awk example2.txt
                # 如果没有以上这行可能会出现错误，或者
                # awk -f script1.awk example2.txt 参数f指脚本文件


BEGIN{
    FS = ":";
    # Initialization
    name = "u";
    pword = "p";
    username = "uid";
    password = "userPassword";
}

{
    str_length = length($0);

    if(str_length == 0 ) {
        if (name != "u" && pword != "p") {
            printf ("%s %s\n", name,pword);
        }
        # If blank, reinitializtion
        name = "u";
        pword = "p";
    } else {
        if ($1 == username) {
            name = $0;
        }
        else if($1 == password) {
            pword = $0;
        }
    }
}

END{
    #这里用记判断最后一行是否为空，否得最后一段数据无法输出
    if(str_length != 0) {
        printf ("%s %s\n", name,pword);
    }
}
