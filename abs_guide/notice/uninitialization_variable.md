## uninitialization variable

character:

* has a null value

* length zero

	if [ -z "$unassigned" ]; then
		echo "unassigned is NULl(length:0)
	fi

* evaluates as 0 in arithmetic operations

	echo "$uninitialized"
	let "uninitialized += 5"
	echo "$uninitialized"
	
