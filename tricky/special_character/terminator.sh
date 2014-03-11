#!/bin/bash
# ;;
# Terminator in a case option [double semicolon].
case "$variable" in
    abc)
        echo "\$variable = abc"
        ;;
    xyz)
        echo "\$variable = xyz"
        ;;
esac
