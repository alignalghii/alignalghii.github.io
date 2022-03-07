#!/user/bin/awk -f

# Remove empty lines,
# but only those that are inside (between) two lines containing MathJax delimiters:
# the one is containing the \[ begin delimiter of MathJaX contents
# and the other containing \[ end delimiter of MathJaX contents.

/\[$/,/\]$/ {
	if (/^$/) next; # `!$0` works too
}

{print;}
