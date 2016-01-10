#!/bin/bash

#
# delete message log


# constsants
LOG_DIR=/var/log
ROOT_UID=0                      # root
LINES=50                        # default number of lines to be saved
E_XCD=86                        # path changer error
E_NOTROOT=87                    # non-root user
E_WRONGARGS=88                  # wrong args

cd $LOG_DIR

# root
if [ $UID -ne $ROOT_UID ]; then
    echo "must be root user."
    exit $E_NOTROOT
fi

# parameter not null
case $1 in
    "")
        lines=LINES             # null
        ;;
    *[!0-9]*)                   # integer以外
        echo "Usage: `basename $0` lines-to-cleanup"
        exit $E_WRONGARGS
        ;;
    *)                          # integer
        lines=$1
        ;;
esac

# change to log directory
# M1;
cd $LOG_DIR
# if [ "$PWD" != "$LOG_DIR"]
if [ `pwd` != "$LOG_DIR" ]; then
    echo "can't change to $LOG_DIR"
    exit $E_XCD
fi

# M2;
cd $LOG_DIR || {
    echo "can't change to $LOG_DIR" >&2
    exit $E_XCD
}

# backup
cp -p messages messages.bk

tail -n $lines messages > messages_tmp
mv messages_tmp messages

echo "log file has been cleaned"

exit 0
