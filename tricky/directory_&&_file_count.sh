#!/bin/bash

# Check out space of direcotry
du -sh

# Check out space of specified directory
du -sh specified_dir

# Check out files in current directory(recursive)
find . -type f | wc -l

# Check out files in specified directory
find specified_dir -type f | wc -l

# Check out numbers of directory in current directory
find . -type d | wc -l
