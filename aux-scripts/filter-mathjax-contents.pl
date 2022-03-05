#!/usr/bin/perl

use strict;
use warnings;

my $flag = 0;

while (<>) {
	$flag = 1 if /\[$/;
		print if $flag;
	$flag = 0 if /\]$/;
}
