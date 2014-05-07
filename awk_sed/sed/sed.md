userguide of sed
================

### Commands

* a: add

* c: replace

* d: delete

* i: insert

* p: print

* s: replace(with regulation expression)

* g: use contents in buffer to replace original file

* n: next line and execute new command

### Original Character Sets(元字符集)

* \(patterns\): save the patterns in order, use \n to call the patterns

#### Delete

+ Delete single line

	`sed -e '1d' example`

	`sed -e '$d' example`

+ Delete multi lines

	`sed -e '1,3d' example`

	`sed -e '2,$d' example`

+ Deltet line using pattern match

	1. with character

		`sed -e '/#/d' example.txt`

	2. with word

		`sed -e '/boy/'d example.txt`

	3. with line

		`sed -e '/line2: boy@/d' example.txt`

	4. with word-2(delete line that not contains word)

		`sed -e '/boy/!d' example.txt`

	5. use range(delete multi lines)

		`sed -e '/line1/,/line3/d' example.txt`(first occurence of 'line3')

		`sed -e '2,/line4/d' example.txt`

		`sed -e '/line2/, 4d' example.txt`

	6. use .* character

		`sed -e '/l.*l/d' example.txt`(lines that contains two 'l')

#### Replace(s: string, c:line/buffer)

+ Replace single line(c)

    `sed -e '1c\apple' example.txt`

    `sed -e '1c apple' example.txt`

    `sed -e '$c\apple' example.txt`

+ Replace multi lines(c)

    `sed -e '1,3c\apple' example.txt`

    `sed -e '1,3c apple' example.txt`

    `sed -e '3,$c newline1\nnewline2' example.txt`(replace lines with multilines)

+ Replace single word(&)

    `sed -e 's/boy/girl/' example.txt`

    `sed -e 's/boy/&\&girl/' example.txt`(&:specify pattern 'boy')

    `sed -e 's/boy/&&girl/' example.txt`(boyboygirl)

    `sed -e 's#line#dot#g' example.txt`(very charcter that follows 's' is reagrded as seperator

+ Change disp order(\n)

    `sed -e 's/\(one\) \(two\) \(three\)/[\3 \2 \1]/' example.txt`(original character)

+ Replace multi words(g)-the whole line words

    `sed -e 's/line/dot/g' example.txt`(replace all the words 'line' to 'dot' in the space)

    `sed -e 's/line/dot/' example.txt`(if 'line' occurs twice in one line, replace the first one)

+ Replace single word(m)-specify word

    `sed -e 's/line/dot/m2' example.txt`

    `sed -e 's/line/dot/2' example.txt`

+ Replace single word(p) and print

    `sed -e 's/line/dot/p' example.txt`(replace the first occurence of 'line' and output to the stdout)

+ Replace single word(w) and write to file

    `sed -e 's/line/dot/w tmp.txt' example.txt`(output the matched lines to tmp.txt)

+ Replace word(s) using position parameter

    `sed -e '/white/s/cat/cats/g' example.txt`(g:all the line)

    `sed -e '/white/s/cat/cats/' example.txt`(only the first occurence)

    `sed -e '1,5 s/line/dot/g' example.txt`

    `sed -e '1,/again/s/line/dot/g' example.txt`

#### insert(i)

+ Insert before line

    `sed -e '/boy/i\line?: girl?' example.txt`

    `sed -e '1i\---------------' example.txt`

    `sed -e '$i\---------------' example.txt'`

+ Insert after line

    `sed -e '/boy/a\line?: girl?' example.txt`

    `sed -e '1a\---------------' example.txt`

    `sed -e '$a\---------------' example.txt`

+ Insertion that will write to the original file

    `sed -i '4i\insertion before line4' example.txt`

    `sed -i '2a\insertion after line2' example.txt`

+ Insertion with s

    `sed -i 's/line/dot/' example.txt >> tmp.txt`

    `sed -i 's/line/dot/g' example.txt >> tmp.txt`

#### Print

+ Print single line

	`sed -n '1p' example`

	`sed -n '$p' example`

    `sed -n 's/^boy/fox/p' example.txt`(start with 'one')

    `sed -n 's/fox$/p' example.txt`(end with 'three')

+ Print multi lines(range)

	`sed -n '2,4p' example`

	`sed -n '2, $p' example`

    `sed -n '/boy/,/fox/p' example.txt`

    `sed -e '/boy/,/fox/p' example.txt`

#### Character replace(字元替换)

    `sed -e 'y/boy/BOY/' example.txt`(replace 'b' with 'B', 'o' wiht 'O' and 'y' with 'Y')

    `sed '1,3y/line/LINE/' example2.txt`

#### Negation(!)

    `sed -e '/elf/!d' example.txt`(delete all lines except lines with 'elf' )

#### Next command(n)

    `sed '/white/{n;s/line/dot/g;}' example.txt`(find line with 'check' and move to next line to execute next command)

    `sed -n -e '/white/n' -e 'p' example.txt`( 表示输出文件，但如果一 行含有字符串echo，则输出包含该字符串的下一行。)

    `sed -n -e 'n' -e 'p' filename`(输出文中的偶数行)

#### Multi commands

+ use ;

    `sed 's/line/& dot/g; 1/i\white example.txt`(without -e parameter)

+ use -e

  `sed -e 'cmd1' -e 'cmd2' filename`
#### Pattern match

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
