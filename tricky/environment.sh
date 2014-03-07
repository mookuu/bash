#!/bin/bash

# normal user's environment
~/.bashrc                       # shell that will be executed every time when open new termail
~/.bashrc_logout                # shell that will be executed when log out
~/.bashrc_profile               # shell that will be executed when log in, only once
~/.bashrc_history               # history of command

# system user's envionment
/etc/bashrc
/etc/profile
/etc/profile.d

# PATH
echo $PATH
# add local environment(current terminal only)
PATH=$PATH:/some/directory
# add global environment(terminal only, logout invalid)
export PATH=$PATH:/some/directory
# add global environment, logout OK
# echo 'export PATH=$PATH:/home/directory' >> ~/.bashrc       # M1, extend every time open new terminal
echo 'export PATH=$PATH:/home/directory' >> ~/.bash_profile # M2
