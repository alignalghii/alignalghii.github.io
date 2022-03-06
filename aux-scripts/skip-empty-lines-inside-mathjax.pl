#!/user/bin/perl

use strict;
use warnings;

my $flag = 0;

while (<>) {
	$flag = 1 if /\[$/;
	print unless $flag && /^$/;
	$flag = 0 if /\]$/;
}
