#!/usr/bin/perl

use strict;
use warnings;

# Print only those lines
# that are inside (between) two lines containing MathJax delimiters:
# the one is containing the \[ begin delimiter of MathJaX contents
# and the other containing \[ end delimiter of MathJaX contents.

my $flag = 0;

while (<>) {
	$flag = 1 if /\[$/;
		print if $flag;
	$flag = 0 if /\]$/;
}
