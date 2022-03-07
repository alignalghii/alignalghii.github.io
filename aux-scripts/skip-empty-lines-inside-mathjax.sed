#!/bin/sed -n -f

# Use it *with* the `-n` i.e. `--silent` i.e. `--quiet` option
# But if You want to use without it, then omit the last line!

# Remove empty lines,
# but only those that are inside (between) two lines containing MathJax delimiters:
# the one is containing the \[ begin delimiter of MathJaX contents
# and the other containing \] end delimiter of MathJaX contents.

/\[$/ h;

/\]$/ h;

/^$/ {
	x;
	/\[/ {
		x;
		d;
	}
	x;
}

p;
