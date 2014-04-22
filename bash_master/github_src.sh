# this shell is used to get the newest src from github.com
# appropriate rights should be added to the shell before running.
# using "chmod +x shell_name"
# in order to use this shell, u should also take the following steps
########################################################################################
# 1: add a schedule
# "crontab -e"
# 0 8 * * * shell_path
# 2: restart the cron service
# sudo service cron restart
# or
# sudo /etc/init.d/cron resart
########################################################################################

#!/bin/sh
# generate file directory
# mkdir /home/gemini/workspace/mcc/newest_src
mkdir /home/ndvr/public/source/github_origin

# log
cd /home/ndvr/public/source
mkdir `date +%Y%m%d_ph2`
mkdir `date +%Y%m%d_ph3`
cd github_origin

# remove the old origin add the new one
git init
#git remote rm origin
git remote add origin git@github.com:mcc-system-sb/NDVR.git
# get the phase 2 src
git pull origin release_ph2
chmod +x -R *
mv * ../`date +%Y%m%d_ph2`

# get the phase 3 src
rm -fr * .git
git init
#git remote rm origin
git remote add origin git@github.com:mcc-system-sb/NDVR.git
git pull origin develop
chmod +x -R *
mv * ../`date +%Y%m%d_ph3`

# remove origin directory
cd ..
rm -fr /home/ndvr/public/source/github_origin

# TODO: change src decode from utf8 to euc-jp

