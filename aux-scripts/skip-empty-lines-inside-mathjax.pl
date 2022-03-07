#!/user/bin/perl

use strict;
use warnings;

# Remove empty lines,
# but only those that are inside (between) two lines containing MathJax delimiters:
# the one is containing the \[ begin delimiter of MathJaX contents
# and the other containing \] end delimiter of MathJaX contents.

my $flag = 0;

while (<>) {
	$flag = 1 if /\[$/;
	print unless $flag && /^$/;
	$flag = 0 if /\]$/;
}
