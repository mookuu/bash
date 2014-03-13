#!/bin/bash

echo "Why can't I write 's between single quotes"

echo

# Within single quotes, every special character except ' gets interpreted literally
# The roundabout method.
echo 'Why can'\''t I write '"'"'s between single quotes'


# both output:
# Why can't I write 's between single quotes
