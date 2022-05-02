[See the shell programs and tools](#top) ||| [Go to the main personal homepage](https://alignalghii.github.io/)

# Auxiliary text-check-and-filter scripts

\+ unit test for the correctness of the auxiliary scripts themselves

## Table of contents

- [Introduction](#introduction)
- [Features / tools](#features--tools)
    - [Table-of-contents generators](#table-of-contents-generators)
        - [Table-of-contents generator for HTML](#table-of-contents-generator-for-html)
        - [Table-of-contents generator for Markdown](#table-of-contents-generator-for-markdown)
    - [MathJax extractor](#mathjax-extractor)
    - [MathJax janitor](#mathjax-janitor)
        - [User-friendly implementations](#user-friendly-implementations)
        - [Challenging implementation](#challenging-implementation)
- [Unit test for the correctness of features themselves](#unit-test-for-the-correctness-of-features-themselves)
    - [Test run sample](#test-run-sample)
    - [Test framework](#test-framework)

## Introduction


This document describes „features” and their corresponding test scenarios, together with the test framowork itself.

The „features” are the little tools themselves: small auxiliary scripts for maintaining a HTML or Markdown document. For example: generating a table-of-contents for a large HTML file automatically out of its `<h1>`, ... `<h4>` ... etc. headers. The table-of-contents should be a possibly nested `<ul>` listing. Nesting must be correct valid HTML5, and it must be also nicely indented.

Such a tool can be done either in sed, AWK, Perl, Raku etc., but it should be also welcome if any such auxiliary tool's correctness could be tested. Unit testing of such a custom self-made tool is itself a self-made mini-framework, in simplest way a shell script organizing and diffing piped results from text-processing tools.

[Up to table-of-contents of this page](#readme) ||| [See the shell programs and tools](#top) ||| [Go to the main personal homepage](https://alignalghii.github.io/)


## Features / tools

First the little auxiliary tools are describes. The common test framework above them proving their correctness comes afterwards.

### Table-of-contents generators

#### Table-of-contents generator for HTML

This is probably the most characteristic and most complex tool of all the other examples.

The tool is expected to be able to generating a table-of-contents for a large HTML file automatically out of its `<h1>`, ... `<h4>` ... etc. section headers. The table-of-contents must be a possibly nested `<ul>` listing. Nesting must be correct valid HTML5, and it must be also nicely indented.

In more details: it finds HTML `<h...>` tags and turn them into `<li><a href="#...">...</a></li>` format. If the section header has an id, it will be used automatically for the generated href of the link (so that the reader can jump from the ToC to any section directly). If the section header does not have an id, then the generated ToC item `<li><a href="#">...</a></li>` will have its section link as an empty "#", waiting for filling it out by hand (human assistance) later.

The exact specification of the expected translation can be seen by comparing the [source sample](unit-test-fixtures/table-of-contents-generator-for-html/simple.source.dat) file with the [expectation sample](unit-test-fixtures/table-of-contents-generator-for-html/simple.expectation.dat) file.

An implementation can be seen in [`table-of-contents-generator-for-html.awk`](table-of-contents-generator-for-html.awk). It exactly satisfies the specification. Maybe it is not too reader-friendly, still, it is much more reader-friendly than the **`sed`** variant, [`table-of-contents-generator-for-html.sed`](table-of-contents-generator-for-html.sed).

Both implementations work with  maintaining a state storing hierarchy level and indentation infos governing the translation process.

Although **`sed`** seems to be like an „assembly” language among those languages for text processing, still, it can give a very drastic insigths into the philosophy of such [data-driven languages](https://en.wikipedia.org/wiki/Data-driven_programming), a huge topics having connections with state machines, event-driven programming, aspect-orinted programming.

#### Table-of-contents generator for Markdown

The tool is expected to be able to generating a table-of-contents for a large Markdown file automatically out of its *`# Section`* and *`## Subsection`* and *`### Subsubsection`* etc. section headers systematically. The table-of-contents will a nested listing reflecting the section hierarchy consisting of section links, named accordingly with the section names and linked to them with appropriate section link names as in GitHub Markdown.

The exact specification of the expected translation can be seen by comparing the [source sample](unit-test-fixtures/table-of-contents-generator-for-markdown/simple.source.dat) file with the [expectation sample](unit-test-fixtures/table-of-contents-generator-for-markdown/simple.expectation.dat) file.

For example, out of the the following sample Markdown file
```markdown
# Floor plan designer
...
## Project goal
...
## Collision detection
...
### Most basic ideas:
...
### Anticipation of falling
...
### The natural sliding effect
...
## Architecture, design patterns, current state of development
...
### Used languages (currently)
...
```
it extracts a table-of-contents section like this:
```markdown
- [Floor plan designer](#floor-plan-designer)
    - [Project goal](#project-goal)
    - [Collision detection](#collision-detection)
        - [Most basic ideas:](#most-basic-ideas)
        - [Anticipation of falling](#anticipation-of-falling)
        - [The natural sliding effect](#the-natural-sliding-effect)
    - [Architecture, design patterns, current state of development](#architecture-design-patterns-current-state-of-development)
        - [Used languages (currently)](#used-languages-currently)
```

An implementation can be seen in [`table-of-contents-generator-for-markdown.sed`](table-of-contents-generator-for-markdown.sed):
```sed
#!/bin/sed -n -f

/^#/ {
	s/^\(#*\)#\s*\(.*\)/\1[\2](#\2)/;

	: tab
        /^\(\ *\)#\(#*\)/ s/#/    /;
	t tab;

	s/^\ */&- /;

	: link-tolowercase
	s/(#\([^)]*\)A\([^)]*\))/(#\1a\2)/;
	s/(#\([^)]*\)B\([^)]*\))/(#\1b\2)/;
	...
	s/(#\([^)]*\)Z\([^)]*\))/(#\1z\2)/;
	s/(#\([^)]*\) \([^)]*\))/(#\1-\2)/;
	t link-tolowercase;

	: link-allowedsymbols
	s/(#\([^)]*\)[^a-zA-Z0-9_-]\([^)]*\))/(#\1\2)/;
	t link-allowedsymbols;

	p;
}

```

It exactly satisfies the specification at least for the simple cases in my projects and in the unit test framework fixture. Although it could be implemented easier in AWK or Perl, this **`sed`** implementation is funnier due to its low-level “regexp assembly” nature. Besides the state machine approach and the regexp-event-driven-programming pattern generally characteristic to **`sed`**,  it specifically exemplifies the conditional branching construct of this funny low-level but still Turing-complete language.


[Up to table-of-contents of this page](#readme) ||| [See the shell programs and tools](#top) ||| [Go to the main personal homepage](https://alignalghii.github.io/)


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

[Up to table-of-contents of this page](#readme) ||| [See the shell programs and tools](#top) ||| [Go to the main personal homepage](https://alignalghii.github.io/)


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

Sed is a challenging twin and parallel to AWK and Perl, and all these three tools are very versatile for custom task in checking or maintaining texts or streams. Together  with the „glue” / „orchestrating” power of shell scripts (Bash or Perl), this can be oranized together into very custom-made ad hoc test framworks adaptable for any imaginable situations.

[Up to table-of-contents of this page](#readme) ||| [See the shell programs and tools](#top) ||| [Go to the main personal homepage](https://alignalghii.github.io/)


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

[Up to table-of-contents of this page](#readme) ||| [See the shell programs and tools](#top) ||| [Go to the main personal homepage](https://alignalghii.github.io/)


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

[Up to table-of-contents of this page](#readme) ||| [See the shell programs and tools](#top) ||| [Go to the main personal homepage](https://alignalghii.github.io/)


### Test framework

Everything is orchestrated by a „big” bash-script, [`unit-test-of-the-scripts.bash`](unit-test-of-the-scripts.bash). It bases also on the [folder structure convention](#top). The feature scripts are executed upon test input data sourcefiles, and the produced actual results are compared with expectation files. Comparisons are done with `diff`.

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

[Up to table-of-contents of this page](#readme) ||| [See the shell programs and tools](#top) ||| [Go to the main personal homepage](https://alignalghii.github.io/)
