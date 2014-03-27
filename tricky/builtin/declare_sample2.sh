#!/bin/bash

foo() {
	declare FOO="bar"	# localvariable
	#FOO="bar"		# same as above
}

bar()
{
	foo
	echo $FOO
}

bar  # Prints nothing.


# Thank you, Michael Iatrou, for pointing this out.
