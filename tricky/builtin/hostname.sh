#!/bin/bash

# Assign the system host name at bootup
# gethostname() sets the BASH internal variable $HOSTNAME
#
echo $HOSTNAME

# show current hostname
hostname

# change hostname 
hostname test


# all configurations in /etc/hosts
# 1: network ip address
# 2: hostname.domain_name
# 3: hostname

127.0.0.1	# loop address
