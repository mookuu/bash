#!/bin/bash

# The $' ... ' quoted string-expansion construct is a mechanism that
# uses escaped octal or hex values to assign ASCII characters to variables, e.g., quote=$'\042'.

# The $'\X' construct makes the -e option unnecessary.

echo; echo "NEWLINE and (maybe) BEEP"
echo $'\n'            # Newline.
echo $'\a'            # Alert (beep).
                      # May only flash, not beep, depending on terminal.


echo $'\t \042 \t'x   # Quote (") framed by tabs.
echo $'\t \x22 \t'x   # Quote (") framed by tabs.

echo "ASCII test"
quote=$'\042'        # " assigned to a variable.
echo "$quote Quoted string $quote and this lies outside the quotes."

# Concatenating ASCII chars in a variable.
triple_underline=$'\137\137\137'  # 137 is octal ASCII code for '_'.
echo "$triple_underline UNDERLINE $triple_underline"

echo

ABC=$'\101\102\103\010'           # 101, 102, 103 are octal A, B, C.
echo $ABC

echo

escape=$'\033'                    # 033 is octal for escape.
echo "$escape"
echo "\"escape\" echoes as $escape"
                                  # no visible output.

echo
