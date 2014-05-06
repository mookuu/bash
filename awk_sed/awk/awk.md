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
<<<<<<< HEAD
	sets the file seperator, FS, to value
	$ awk -F: '{print $1"@"$2}' example2.txt
	$ awk -F: '{printf"%s@%\n", $1, $2}' example2.txt
=======
	sets field seperator to value, default space or tab

>>>>>>> 8f93f28325c69323c72130935883c711d1a8b637

Builtin-variables

	OFS       inserted between fields on output, initially = " ".

