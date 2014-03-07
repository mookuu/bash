#!/bin/bash

# check current alias
alias

# creat alias
alias shortcut='command'        # add to ~/.bashrc or /etc/profile/alias.sh
alias use='du -h --max-depth=1 | sort -n | more'
echo "alias use='du -h --max-depth=1 | sort -h | more'" >> ~/.bashrc

# undo alias
unalias alias
