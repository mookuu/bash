#!/bin/bash

#  Kill process

#  Find PID
ps aux | grep regular_expression

#  M1:
kill [signal] PID
#  [9]: force quit
kill -9 PID
kill -SIGKILL PID	# SIGKILL=9

#  M2:
killall process_name		# kill all the process(subprocess included)
killall -9 process_name		# force kill all the process


#  M3
pkill process_name


