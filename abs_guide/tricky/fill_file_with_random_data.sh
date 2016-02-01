#!/bin/bash

# fill file with random data
#

# M1;
head -c 1M </dev/urandom >tmp_random_file_1M_0

# M2;
# in case system doesn't understand the M suffix
head -c 1048576 </dev/urandom >tmp_random_file_1M_1



# M3;
# non-POSIX system, freeBSD for example
dd bs=1024 count=1024 </dev/urandom >tmp_random_file_1M_2

# M4;
# size: 1M←/dev/zero
# contents なし
dd if=/dev/zero of=tmp_random_file_1M_3 bs=1M count=1
# file of size 2M
dd if=/dev/zero of=tmp_random_file_1M_3 bs=1M count=2
