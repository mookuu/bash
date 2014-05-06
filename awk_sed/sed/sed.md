userguide of sed
================

## Command

* a: add

* c: replace

* d: delete

* i: insert

* p: print

* s: replace(with regulation expression)

* g: use contents in buffer to replace original file

### Delete

* sed '1d' example

* sed '$d' example

* sed '1,3d' example

* sed '2,$d' example

* sed '/insert/'d example.txt

	delete all the lines that contain insert in example.txt

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

### insert(change origin file)

* sed -i '2a\inset line:\/usr\/bin' example

* sed -i '2ainset line:/usr/bin' example

* sed -i '2ainsert line:/usr/bin' example


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


