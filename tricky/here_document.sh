#!/bin/bash
# here document use for print multiple lines, same as echo*n

# cat > $Newfile <<End-of-message
# writes the output to the file $Newfile, rather than to stdout.
cat <<End-of-message
-------------------------------------
This is line 1 of the message.
This is line 2 of the message.
This is line 3 of the message.
This is line 4 of the message.
This is the last line of the message.
-------------------------------------
End-of-message


echo "-------------------------------------
This is line 1 of the message.
This is line 2 of the message.
This is line 3 of the message.
This is line 4 of the message.
This is the last line of the message.
-------------------------------------"
# However, text may not include double quotes unless they are escaped.
mysql -u root << Command-Included
use mysql
select * from user;
exit
Command-Included
