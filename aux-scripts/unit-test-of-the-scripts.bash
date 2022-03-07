#!/bin/bash

here=`dirname "$0"`;
# it can differ from `pwd` if the script is called from elsewhere (just like now: called from `src/Makefile`)
# Credit to: https://stackoverflow.com/questions/59895/how-can-i-get-the-source-directory-of-a-bash-script-from-within-the-script-itsel

fixture=$here/unit-test-fixtures;

# Implementation languages of the scripts to be tested:
declare -A run=([pl]="perl" [awk]="awk -f" [sed]="sed -n -f");

echo "Unit test";
for feature in filter-mathjax-contents skip-empty-lines-inside-mathjax;
	do
		echo "- Feature: $feature";
		find $fixture/$feature -iname '*.source.dat'\
		|
		while read sourceFile; # looped reading fom a list coming through pipeline
			do
				sampleName=${sourceFile%.source.dat};
				echo "  Samples:"
				echo "  - Sample \``basename $sampleName`':";
				echo "    Testers:";
				for extension in ${!run[@]};
					do
						# The actual comparions:
						echo -en "    - Tester \`${run[$extension]}': ";
						if diff <(${run[$extension]} $here/$feature.$extension $sourceFile) $sampleName.expectation.dat;
							then echo OK;
							else echo Wrong;
						fi;
				done;
		done;
done;
