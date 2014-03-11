#!/bin/bash

if [ -x "$filename" ]; then # Note the space after the semicolon.
        echo "File $filename exists."; cp $filename $filename.bak
        echo "File $filename exists."
        cp $filename $filename.bak
else
        echo "File $filename not found."; touch $filename
fi; echo "File test complete."
