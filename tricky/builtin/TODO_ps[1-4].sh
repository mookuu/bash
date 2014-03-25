#!/bin/bash

#
# PS1
# PS2
# PS3
# PS4
#PS4='$(read time junk < /proc/$$/schedstat; echo "@@@ $time @@@ " )'
# Per suggestion by Erik Brandsberg.
set -x
# Various commands follow ...
echo "a"

[ -n $1 ] && echo "b" || exit 0

echo "c"
