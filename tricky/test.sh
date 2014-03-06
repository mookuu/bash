一、shell指令执行的顺序
bash启动的时候会默认打开3个文件描述符，当它运行一条指令的时候，会先fork一个子进程，子进程会继承这3个文件描述符，然后设定好重定向之后，再执行指令。严格按照这个顺序会很容易理解重定向。


需要注意的几点是：

        1. 如果指令中有多个重定向，重定向的顺序是很关键的，因为重定向是按照从左向右解析的。

        2. 如果只有一个重定向的话，那么它在指令的位置可以任意，因为bash是先解析重定向，然后将重定向从指令中去除以后再执行指令。

        3. 重定向符号如果以‘<’开头，是指对标准输入（fd= 0）进行重定向；如果是以'>'开头，则是对标准输出（fd= 1）重定向，这点后面还会继续强调。

        4. 下面所有列举的重定向格式中的 word 除特意指明以外，都是指各种扩展之后的效果，本文只针对重定向，这些扩展具体可以查看bash的参考手册，在这里我们就使用不带任何扩展、最简单的文件名来说明。


重定向就是针对文件描述符的操作，理解到这一点，重定向也就不难了。


二、输入重定向（Redirecting Input）
格式：[n]<word
说明：将文件描述符n重定向到word指代的文件（以读的方式打开），如果n省略（第3个注意项），则是将标准输入重定向。
举例：

[plain] view plaincopyprint?

        1. $ cat < file  # 等价于cat 0<file


子进程的shell在继承3个文件描述符以后，解析到重定向符号‘<'，然后将标准输入重定向到file，之后执行cat指令，cat指令从标准输入读取数据，标准输入由于已定向到file，所以就转而从file中读取输入内容。


三、输出重定向（Redirecting Output）
格式：[n]>[|]word
说明：将文件描述符n重定向到word指代的文件（以写的方式打开），如果n省略（第3个注意项），则是将标准输出重定向。bash有一个内建选项noclobber，是用来防止文件被覆盖写入，默认是关闭的，可以通过指令
[plain] view plaincopyprint?

        1. set -o noclobber

开启该功能（o代表open，关闭使用set +o noclobber），开启以后输出重定向会执行失败。'|' 字符是用于在开启该功能的情况下强制执行重定向。
举例：

[plain] view plaincopyprint?

        1. $ set -o noclobber
        2. $ touch file
        3. $ ls > file   # 等价于ls 1>file
        4. bash: file: cannot overwrite existing file
        5. $ ls >| file
        6. $ cat file
        7. file


首先开启noclobber功能，创建一个空文件file，然后在执行ls > file的时候，标准输出首先重定向到file，执行ls时打印到标准输出的结果会写入到file，但是noclobber使文件不能被写入。在使用>|以后，就可以强制写入file了。
注意：建议将noclobber功能追加到.bashrc文件中，

[plain] view plaincopyprint?

        1. echo 'set -o noclobber' >> .bashrc     # 注意是“>>”


这样会防止平时误操作导致文件被覆盖，需要强制的时候只需要加上‘|’符号即可。


四、附加输出重定向（Appending Redirected Output）
格式：[n]>>word
说明：与输出重定向类似，只是word代表的文件是以附加方式打开，所以不受noclobber的影响。


五、标准输出与标准错误输出重定向（Redirecting Standard Output and Standard Error）
格式：&>word 或 >&word
说明：将标准输出与标准错误输出都定向到word代表的文件（以写的方式打开），两种格式意义完全相同，不过更推荐使用前者（手册上没有说明为什么，个人认为是为了与下面要提到的附加标准输出与标准错误输出重定向格式相对应），格式等价于>word2>&1（2>&1是将标准错误输出文件描述符复制到标准输出，后面还会说明）
举例：

[plain] view plaincopyprint?

        1. $ ls &> file
        2. $ cat file
        3. file
        4. $ mkdir &>file    # 开启noclobber功能重定向会失效
        5. $ cat file
        6. mkdir: missing operand
        7. Try `mkdir --help' for more information.


从ls &> file中可以看出ls到标准输出的内容写入到了file中，说明标准输出重定向。然后执行了一条错误的mkdir指令，终端上没有显示出任何错误信息，而打印file的内容，可以看到错误信息被写入到了file中去，说明标准错误输出重定向。


六、附加标准输出与标准错误输出重定向（Appending Standard Output and Standard Error）
格式：&>>word
说明：与标准输出与标准错误输出重定向类似，只是word代表的文件是以附加方式打开，所以不受noclobber的影响。格式等价于>>word 2>&1。


七、复制文件描述符（Duplicating File Descriptors）
格式：(1)[n]<&word (2) [n]>&word
说明：word是用数字表示的文件描述符（注意不是文件名了），表示将文件描述符n复制到word，前者是以读的方式打开，后者是以写的方式打开。这里不用digit而是依然用word来指代文件描述符的原因可以由第五点来说明，如果n省略，那么(2)就变成了>&word的形式，而这里的word还是代表文件名。
为了更清晰解释这部分内容，我们用图来说明cmd &>file的等价形式cmd >file 2>&1执行的过程（图中的/dev/tty0代表终端）。
第一步，创建shell子进程，子进程继承3个文件描述符


第二步，从左到右解析重定向符号，>file是将标准输出重定向到file。


然后2>&1将标准错误输出复制到标准输出。


第三步，去除所有重定向，执行cmd指令，标准错误输出和标准输入都会重定向到file中。
注意在这里重定向的顺序很重要，如果执行的指令是cmd 2>&1 >file，那么重定向会先将标准错误输出复制到标准输出，再将标准输出定向到file。像下面这两张图




举例：

[plain] view plaincopyprint?

        1. $ set +o noclobber
        2. $ mkdir >file 2>&1
        3. $ cat file
        4. mkdir: missing operand
        5. Try `mkdir --help' for more information.
        6. $ mkdir 2>&1 >file
        7. mkdir: missing operand
        8. Try `mkdir --help' for more information.
        9. $ cat file
        10. $


首先关闭noclobber功能，由运行结果可以看到，先定向再复制的话，标准错误输出会写入到file中，而先复制后定后的话，由于标准输出没有任何结果，所以标准错误输出打印到了终端上，而file文件则为空。


八、移动文件描述符（Moving File Descriptors）
格式：[n]<&digit- 或 [n]>&digit-
说明：类似于复制，只是在复制完成之后，文件描述符n会关闭。注意这里的文件描述符是用digit来指代的，因为不会有其他意义。


九、读写打开文件描述符（Opening File Descriptors for Reading and Writing）
格式：[n]<>word
说明：以读写方式打开word指代的文件，并将n重定向到该文件。如果n不指定的话，默认为标准输入。
举例：

[plain] view plaincopyprint?

        1. $ exec 3<>file
        2. $ ls >&3
        3. $ cat file
        4. file
        5. $ cat <&3
        6. $ exec 3<>file
        7. $ cat <&3
        8. file


将文件描述符3定向到file，然后把标准输出定向到3以后，标准输出的内容就写入到file中。同样从标准输入读的时候，将标准输入定向到3，会打印出file的内容。由上面的结果还能看到exec3<>file只针对一条指令有效。


十、Here文件（Here Documents）
格式：
<<[-]word
here-document
delimiter
说明：指定shell从当前输入源中读入行直至遇到仅包含word的一行（word后面也不能有空白符），然后所有读入的内容（不包括最后一行）作为标准输入传递给指令。'-'的作用是将每一行前面的tab去除后再读入。需要注意的是这个word不会进行任何扩展，但是如果word中没有字符没引号扩起来，那么here-document中的内容可以进行参数扩展、指令替换以及算术扩展（parameterexpansion, command substitution, and arithmeticexpansion）；只要有任一字符被引号扩起来，delimiter仍是将去除引号的word，但是输入行不会进行任何扩展。
举例：

[plain] view plaincopyprint?

        1. $ cat <<EOF
        2. > $(pwd)     # 指令替换
        3. > `pwd`      # 指令替换的第2种形式
        4. > $HOME      # 参数扩展
        5. > $((4+5))   # 算数扩展
        6. > EOF
        7. /home/leo
        8. /home/leo
        9. /home/leo
        10. 9
        11. $ cat <<"EOF"
        12. > $(ls)
        13. > `pwd`
        14. > $HOME
        15. > $((4+5))
        16. > EOF
        17. $(ls)
        18. `pwd`
        19. $HOME
        20. $((4+5))


第一次没有将EOF用引号扩起来，三种扩展都能正常展开，而第二次用引号扩起来以后，原样输出。


十一、Here字符串（Here Strings）
格式：<<<word
说明：将扩展后的word作为标准输入传递给指令。
举例：使用这个功能可以将指令
echo 'something' |command
通过下面这种方式来实现
command <<<'something'。


参考资料：
1. Bash Reference Manual: http://www.gnu.org/software/bash/manual/bashref.html#Redirections
2. Bash One-Liners Explained, Part III: All about redirections: http://www.catonmat.net/blog/bash-one-liners-explained-part-three/
