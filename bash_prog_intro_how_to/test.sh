#!/bin/bash

# Screen deal
reset;clear
info="System will be locked!!! Press Waitting....."
printf "\n\n\n\n\n\n\n"
#for i in 9 8 7 6 5 4 3 2 1 0
for i in 3 2 1 0
do
    printf "                \a$info$i\r"
    sleep 1
done
clear

# Catch 'CTRL+C' 'CTRL+X' 'CTRL+\' signal
trapper()
{
    trap '' 2 3 20
}

# Lock the screen
while :
do
    trapper
    printf "\n\n\n\n\n\n\n\n\t\tPlease enter unlock code:"
    stty -echo                  # hide the input characters
    read input
    case $input in
        123)
            printf "\n\t\t    Hello, $USER, Today is $(date +%T)\n"
echo             ★★★★★★★★★★★★★★★★★★★★
echo ★　　　　　　　　　　　　　　　　　　★
echo ★　　　　　　　　　　　　　　　　　　★
echo ★　　　　　　　　　　　　　　　　　　★
echo ★★★★★★★★★★★★★★★★★★★★
            stty echo
            break;;
        *)
            clear
            continue
            ;;
        esac
done
# script over
