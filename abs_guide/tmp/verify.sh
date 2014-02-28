#!/bin/bash

if [ -f "test_dir" ]; then
    echo "file!"
elif [ -d "test_dir" ]; then
    echo "directory!"
else
    echo "other!"
fi
