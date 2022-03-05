#!/bin/sed -n -f
# Run it with command-line option `-n` i.e. `--silent` i.e. `--quiet`
# Printing is explicitly coded.

#################
# Specification #
#################

# Print only those lines
# that are inside (between) two lines containing MathJax delimiters:
# the one is containing the \[ begin delimiter of MathJaX contents
# and the other containing \[ end delimiter of MathJaX contents.

##################
# Implementation #
##################

##################################
# Implementation / logical part I:

# If the \] end delimiter of MathJaX contents is detected,
# then print all the gathered MathJax contents,
# and restart script with the line reading!

/\\\]$/{
	# Print the hold space:
	x;
		p;
	x;

	# Print the pattern space:
	p;

	# Jump to next cycle of the reading loop:
	d
}

###################################
# Implementation / logical part II:

# If the \[ begin delimiter of MathJaX contents is detected,
# then go into ``contents gathering mode'':
# from now on, at each cycle of the reading loop,
# add the line to the hold space and resrart script with the next line!

# Including the line of the begin delimiter itself:

/\\\[$/{
	h;
	d;
}

# And also including the subsequent lines:

x;
	/\[/{
		x;H;x
	}
x;
