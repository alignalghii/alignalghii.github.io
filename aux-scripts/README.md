# Auxiliary text-check-and-filter scripts

\+ unit test for the correctness of the auxiliary scripts themselves

## Features

### MathJax extractor

Show only the MathJax environments of a markdown document!
(Those lines that are inside the \\[ and \\] MathJax delimiters).


The `filter-mathjax-contents` script family:

- `filter-mathjax-contents.pl`
- `filter-mathjax-contents.awk`
- `filter-mathjax-contents.sed`

#### User-friendly implementations

The AWK programming language allows **ranges** in its syntax:
```awk
/\\[$/, /\\[$/
```
Due to well-chosen default behaviors of the language, this phrase does the job in itself alone and is a valid AWK program!

Perl is more verbose here, but its logic is still friendly and inspiring:

```perl
my $flag = 0;

while (<>) {
	$flag = 1 if /\[$/;
	print unless $flag && /^$/;
	$flag = 0 if /\]$/;
}
```

#### Challenging implementation

Sed proves also here that she is the ultimate „assembly language” of text processing.
Thoretically she knows everything what his strong brothers, AWK and Perl can do (she is Turing complete!), but Sed keeps being a kind of assembly language:

```sed
/\\\]$/ {
	# Print the hold space:
	x;
		p;
	x;

	# Print the pattern space:
	p;

	# Jump to next cycle of the reading loop:
	d
}

/\\\[$/ {
	h;
	d;
}

x;
	/\[/ {
		x;H;x
	}
x;
```

This is not so obscure as it seems first (see the comments in the [source code](filter-mathjax-contents.sed)). In essence, it uses flags like the perl sample, but Sed lacks variables, it is like an assembly language. Sed uses the „pattern space” and „hold space” as sort-of registers instead of variables, that is its way to implement statefulness. Here, in the sample, the trick of algebraic conjoint is used: some operations can be implemented well by swapping these two registers, doing the intended operation, and finally swapping the registers back.

### MathJax janitor

Remove empty lines (regarded as superfluous and distracting),
but only those that are inside the \\[ and \\] MathJax delimiters
(because outside MathJax environments, empty lines can be important in a markdown document).

The `skip-empty-lines-inside-mathjax` script family:

- `skip-empty-lines-inside-mathjax.pl`
- `skip-empty-lines-inside-mathjax.awk`
- `skip-empty-lines-inside-mathjax.sed`

To show the two opposites with regards of implementation, let us contrast Perl and Sed:

Perl:
```perl
my $flag = 0;

while (<>) {
	$flag = 1 if /\[$/;
	print unless $flag && /^$/;
	$flag = 0 if /\]$/;
}
```

Sed:
```sed
/\[$/ h;

/\]$/ h;

/^$/ {
	x;
	/\[/ {
		x;
		d;
	}
	x;
}

p;
```

See details in the respective [Perl source file](skip-empty-lines-inside-mathjax.pl) and [Sed source file](skip-empty-lines-inside-mathjax.sed).

## Unit test for the correctness of features themselves

### Test run sample

```
me@my-computer:~/Documents/my-blog/alignalghii.github.io$ aux-scripts/unit-test-of-the-scripts.bash
Unit test
- Feature: filter-mathjax-contents
  Samples:
  - Sample `simple-embedded-mathjax-content':
    Testers:
    - Tester `perl': OK
    - Tester `sed -n -f': OK
    - Tester `awk -f': OK
- Feature: skip-empty-lines-inside-mathjax
  Samples:
  - Sample `simple-embedded-mathjax-content':
    Testers:
    - Tester `perl': OK
    - Tester `sed -n -f': OK
    - Tester `awk -f': OK
  Samples:
  - Sample `empty':
    Testers:
    - Tester `perl': OK
    - Tester `sed -n -f': OK
    - Tester `awk -f': OK
  Samples:
  - Sample `nontrivial-general-case':
    Testers:
    - Tester `perl': OK
    - Tester `sed -n -f': OK
    - Tester `awk -f': OK
me@my-computer:~/Documents/my-blog/alignalghii.github.io$
```

### Test framework

Everything is orchestrated by a „big” bash-script. The feature scripts are executed upon test input data sourcefiles, and the produced actual results are compared with expectation files. Comparisons are done with `diff`.

```bash
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
```

See the [Bash sourcecode file](unit-test-of-the-scripts.bash).