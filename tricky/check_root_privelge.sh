#!/bin/bash

ROOT_UID=0
if [ "$UID" -ne "$ROOT_UID" ]; then
        echo "not the root user"
else
        echo "the root user"
fi
