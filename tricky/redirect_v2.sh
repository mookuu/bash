#!/bin/bash
1.0
文件                    文件描述符
输入文件—标准输入	0（缺省是键盘,为0时是文件或者其他命令的输出）
输出文件—标准输出	1（缺省是屏幕，为1时是文件）
错误输出文件—标准错误	2（缺省是屏幕，为2时是文件） 系统中实际上有12个文件描述符，我们可以任意使用文件描述符3到9.
1.1
Command > filename	把标准输出重定向到一个新文件中
Command >> filename	把标准输出重定向到一个文件中（追加）
Command > filename	把标准输出重定向到一个文件中
Command > filename 2>&1	把标准输出和错误一起重定向到一个文件中
Command 2 > filename	把标准错误重定向到一个文件中
Command 2 >> filename	把标准输出重定向到一个文件中（追加）
Command >> filename2>&1	把标准输出和错误一起重定向到一个文件（追加）
1.2.输入重定向：
Command < filename > filename2	Command命令以filename文件作为标准输入，以filename2文件作为标准输出
Command < filename	Command命令以filename文件作为标准输入
Command << delimiter    从标准输入中读入，知道遇到delimiter分界符
delimiter
1.3.绑定重定向
Command >&m	把标准输出重定向到文件描述符m中
Command < &-	关闭标准输入
Command 0>&-	同上
