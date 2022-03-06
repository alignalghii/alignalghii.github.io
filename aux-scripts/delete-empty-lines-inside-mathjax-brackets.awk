#!/usr/bin/awk

# Delete on-empty lines,
# but only those ones that are inside MathJax delimiting \[...\] brackets...!

/\[$/,/\]$/ {           # Inside MathJax delimiting \[...\] brackets...
	if (/./) print; # ... print only non-empty lines... (Note that `if ($0) print` works too)
	next;           # ... otherwise (i.e., in cases when we are *not* nside MathJax delimiting \[...\] brackets...
}

{
	print;          # ... print the line (unconditionally)
}
