userguide of sed
================

## Commands

* a: add

* c: replace

* d: delete

* i: insert

* p: print

* s: replace(with regulation expression)

* g: use contents in buffer to replace original file

* n: next line and execute new command

### Delete

+. Delete single line

	`sed -e '1d' example`

	`sed -e '$d' example`

2. Delete multi lines

	* sed -e '1,3d' example

	* sed -e '2,$d' example

3. Deltet line using pattern match

	1. with character

		* sed -e '/#/d' example.txt

	2. with word

		* sed -e '/boy/'d example.txt

	3. with line

		* sed -e '/line2: boy@/d' example.txt

	4. with word-2(delete line that not contains word)

		* sed -e '/boy/!d' example.txt

	5. use range(delete multi lines)

		* sed -e '/line1/,/line3/d' example.txt(first occurence of line3)

		* sed -e '2,/line4/d' example.txt

		* sed -e '/line2/, 4d' example.txt

	6. use .* character

		* sed -e '/l.*l/d' example.txt(lines that contains two l)
### print

* sed -n '1p' example

* sed -n '$p' example

* sed -n '2,4p' example

* sed -n '2, $p' example

### pattern match

* sed -n '/hhkb/p' example

	search line that contains hhkb

* sed -n '/\$/p' example

	search line that contains $, use escape character(backslash) to print origin $

### add

* sed '1a add1' example2

	add one line(newline) after line1

* sed '$a add1' example2

	add one line at the end of example

* sed '2,4a add2' example2

	add one line after each from line 2 to line 4

* sed '1a add1\nadd2' example

	add two lines

* sed '/^line/a\\---->addition using pattern match' example2.txt

* sed '/funn$/a\\---->addition using pattern match' example2.txt

### replace(c)-line oriented

sed '1c replace1' example3

	replace line 1 with replace1

sed '$c replace1' example3

	replace last line with replace1

sed '1,2c replace2' example3

	replace line 1 and line 2 with replace2

sed '2,$c replace3' example3

	replace from line 2 to last line with replace3

### replace(s)-words oriented

* sed 's/insert/insert-2/' example.txt

	replace the first occurence of insert in a line with insert-2

* sed 's/insert/insert-2/g' example.txt

	replace all the occurences of insert with insert-2

* sed -n 's/^insert/insert-2/p' example.txt

	print only the line that start with insert after being replaced by insert-2

* sed 's/insert/-&-/' example.txt

	replace insert with -insert-

* sed -n 's/\(insert\)-2/\1ion/p' example.txt

	replace insert-2 with insertion(mark insert as 1)

$ sed 's#insert#insertion#g' example.txt

	不论什么字符，紧跟着s命令的都被认为是新的分隔符，所以，“#”在这里是分隔符，代替了默认的“/”分隔符。表示把所有10替换成100。

* sed -i 's/hhkb/hhkb-2/' example.txt > example.txt.out

* mv example.txt.out example.txt

* sed -i 's/hhkb/hhkb-2/g' example.txt

* sed -i 's,hhkb,hhkb-2,g' example.txt

* sed -i 's#hhkb#hhkb-2#g' example.txt

* sed -i 's,/usr/bin,/usr/local/bin,g' example

	replace /usr/bin with /usr/local/bin

### insert(i)

* sed -i '2a\inset line:\/usr\/bin' example

* sed -i '2ainset line:/usr/bin' example

* sed -i '2ainsert line:/usr/bin' example

* sed '/check/i\\insertion test' example2.txt

### line range(, comma)

* sed -n '2,/^insert/p' example.txt

	print from line 2 to line that satart with insert

* sed -n '/line1/,/funn/p' example2.txt

	print line from line starts with 'line1' to line end with 'funn'

	if doesn't contain line1, output nothing; if contains line1 but not 
	
	funn, output the whole line from the line contains line1

* sed -n '/line1/,/funn/s/$/ line-end/p' example2.txt

	same as upper case except replace last line with ' line-end'

### multiple command lines(multipoint edit)

* sed -e '1,3d' -e 's/insert/insertion/' example.txt

	execute the two commands by turn

* sed --expression='s/insert/insertion/' --expression='s/hhkb/hhkb-2/' example.txt

	same as upper

### read from file(r)

* sed '/insert/r example3.txt' example.txt

	patter match, search insert from example and add contents of example3.txt to the folling of every matched line

### write file(w)

* sed -n '/insert/w example3.txt' example.txt

	write matched patterns to example3.txt


Command(n)-next line

* sed '/check/{n;s/funn/funn-addition/;}' example2.txt

	find line with 'check' and move to next line to execute next command

Command(y)-alphabet case change

* sed '1,3y/line/LINE/' example2.txt

	replace 'line' in line 1 to line3 to 'LINE'

Command(q)-quit

* sed '3q' example2.txt

	print line 3 and quit sed

Command(h G)

* sed -e '/check/h' -e '$G' example2.txt

	comannd1: find line with 'check' and save to buffer
	
	command2: get from buffer and save to file

* sed -e '/check/h' -e '/funn/x' example2.txt

	comannd1: find line with 'check' and save to buffer

	command2: replace from buffer with funn
