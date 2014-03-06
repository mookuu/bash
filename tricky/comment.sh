#!/bin/bash

# COMMENT MULTIPLE LINES

# M1: specific marks
cat <<EOF
-------------------
# M1: specific marks
:||{
    ....comment out sentence
}
EOF

# M2: use if
cat <<EOF
-------------------
# M2: use if
if false ; then
....comment out sentence
fi
EOF

-------------------
