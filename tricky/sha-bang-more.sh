#!/bin/more
# Self-listing script.

# Nothing much seems to happen when you run this... except that the file contents list.
# Same as here documentation.

WHATEVER=85

echo "This line will never print (betcha!)."

exit $WHATEVER  # Doesn't matter. The script will not exit here.
                # Try an echo $? after script termination.
                # You'll get a 0, not a 85.
