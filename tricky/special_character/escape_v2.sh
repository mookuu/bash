variable=\
echo "$variable"
# Will not work - gives an error message:
# test.sh: : command not found
# A "naked" escape cannot safely be assigned to a variable.
#
#  What actually happens here is that the "\" escapes the newline and
#+ the effect is        variable=echo "$variable"
#+                      invalid variable assignment

variable=\
23skidoo
echo "$variable"        #  23skidoo
                        #  This works, since the second line
                        #+ is a valid variable assignment.

variable=\
#        \^    escape followed by space
echo "$variable"        # space

variable=\\
echo "$variable"        # \

variable=\\\
echo "$variable"
# Will not work - gives an error message:
# test.sh: \: command not found
#
#  First escape escapes second one, but the third one is left "naked",
#+ with same result as first instance, above.

variable=\\\\
echo "$variable"        # \\
                        # Second and fourth escapes escaped.
                        # This is o.k.
