#/usr/bin/awk -f

# Print only those lines
# that are inside (between) two lines containing MathJax delimiters:
# the one is containing the \[ begin delimiter of MathJaX contents
# and the other containing \[ end delimiter of MathJaX contents.

/\\\[$/,/\\\]$/
