#!/bin/bash

here=`dirname "$0"`;
fixture=$here/unit-test-fixtures;

declare -A run=([pl]="perl" [awk]="awk -f" [sed]="sed -n -f");

echo "Unit test";
for feature in filter-mathjax-contents skip-empty-lines-inside-mathjax;
	do
		echo "- Feature: $feature";
		find $fixture/$feature -iname '*.source.dat'\
		|
		while read sourceFile;
			do
				sampleName=${sourceFile%.source.dat};
				expectationFile=$sampleName.expectation.dat;
				echo "  Samples:"
				echo "  - Sample \``basename $sampleName`':";
				echo "    Testers:";
				for extension in ${!run[@]};
					do
						echo -en "    - Tester \`${run[$extension]}': ";
						if diff <(${run[$extension]} $here/$feature.$extension $sourceFile) $sampleName.expectation.dat;
							then echo OK;
							else echo Wrong;
						fi;
				done;
		done;
done;
