#!/bin/bash

here=`dirname "$0"`;
fixture=$here/unit-test-fixtures;
mathjaxFilterer=$here/filter-mathjax-contents;

declare -A run=([pl]="perl" [awk]="awk -f" [sed]="sed -n -f");

echo $fixture/*.source.dat\
|
while read sourceFile;
	do
		sampleName=${sourceFile%.source.dat};
		expectationFile=$sampleName.expectation.dat;
		echo "Samples:"
		echo "- Sample \``basename $sampleName`':";
		echo "  Testers:";
		for extension in ${!run[@]};
			do
				echo -en "\t- Tester \`${run[$extension]}': ";
				if diff <(${run[$extension]} $mathjaxFilterer.$extension $sourceFile) $sampleName.expectation.dat;
					then echo OK;
					else echo Wrong;
				fi;
		done;
done;
