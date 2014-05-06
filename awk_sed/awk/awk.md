AWK manual
==========

awk '{if($5>20||$5==10) {print $1}}' example.txt

-n --quit --silent
	Do not print current line that being dealing(default print current line)

-e
	Specify edit command
	'='  print line number
	'p'  print current line
	's/str1/str2'  replace str1 with str2

-f script_file
	Execute script file(with edit command in)
	$ awk -f test.awk example.txt

-F value
	sets the file seperator, FS, to value
	$ awk -F: '{print $1"@"$2}' example2.txt
	$ awk -F: '{printf"%s@%\n", $1, $2}' example2.txt

