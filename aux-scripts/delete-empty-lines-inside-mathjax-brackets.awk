#!/usr/bin/awk

# Delete on-empty lines,
# but only those ones that are inside MathJax delimiting \[...\] brackets...!

/\[$/,/\]$/ {           # Inside MathJax delimiting \[...\] brackets...
	if ($0) print;  # ... print only non-empty lines...
	next;           # ... otherwise (i.e., in cases when we are *not* nside MathJax delimiting \[...\] brackets...
}

{
	print;          # ... print the line (unconditionally)
}
