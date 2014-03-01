#!/bin/bash
# origin src comes from linuxsir.
# Modified by RyanH@osk 2014-3-1.
# enjoy!

# TODO: forbidden other terminal windows


# Screen deal
reset;clear
info="System will be locked!!! Please Waitting....."
printf "\n\n\n\n\n\n\n"
for i in 9 8 7 6 5 4 3 2 1 0
#for i in  1                     # for test
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
    printf "\n"
cat <<EOF
                      _______________________________
                     < Your System ate a SPARC! Gah! >
                      -------------------------------
                             \   ^__^
                              \  (xx)\_______
                                 (__)\       )\/\

                                  U  ||----w |
                                     ||     ||
EOF
    printf "\n\t\t\t"
    printf "Please enter unlock code:"
    stty -echo                  # hide the input characters
    read input
    case $input in
        kohata|KOHATA)
            printf "\n\t\t\n"
            cat <<EOF
                        ★★★★★★★★★★★★★★★★★★★★★★★★★
                        ★　                     ★
                        ★　Welcome back, $USER.  ★
                        ★　Today is $(date +%F)  ★
                        ★                       ★
                        ★★★★★★★★★★★★★★★★★★★★★★★★★
EOF
            stty echo
            break;;
        *)
            clear
            continue
            ;;
        esac
done
# script over
