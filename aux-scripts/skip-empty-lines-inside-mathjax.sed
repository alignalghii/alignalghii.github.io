#!/bin/sed -n -f

# Use it *with* the `-n` i.e. `--silent` i.e. `--quiet` option
# But if You want to use without it, then omit the last line!

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
