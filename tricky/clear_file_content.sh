# M1: use /dev/null
cat /dev/null > wtmp
# M2: use special character colon(:)
: > wtmp                      # builtin, this will not fork a new process
# M3: use space character
> wtmp
