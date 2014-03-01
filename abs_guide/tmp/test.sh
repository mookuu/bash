#!/bin/bash


cat <<EOF
here document
EOF

echo $(date)
echo $(date +%a\ %b\ %e\ %Z\ %Y)
#echo $(date +%a\ %b\ %_d)
echo $(date +%F)
