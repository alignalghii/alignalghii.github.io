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
	s/(#\([^)]*\)C\([^)]*\))/(#\1c\2)/;
	s/(#\([^)]*\)D\([^)]*\))/(#\1d\2)/;
	s/(#\([^)]*\)E\([^)]*\))/(#\1e\2)/;
	s/(#\([^)]*\)F\([^)]*\))/(#\1f\2)/;
	s/(#\([^)]*\)G\([^)]*\))/(#\1g\2)/;
	s/(#\([^)]*\)H\([^)]*\))/(#\1h\2)/;
	s/(#\([^)]*\)I\([^)]*\))/(#\1i\2)/;
	s/(#\([^)]*\)J\([^)]*\))/(#\1j\2)/;
	s/(#\([^)]*\)K\([^)]*\))/(#\1k\2)/;
	s/(#\([^)]*\)L\([^)]*\))/(#\1l\2)/;
	s/(#\([^)]*\)M\([^)]*\))/(#\1m\2)/;
	s/(#\([^)]*\)N\([^)]*\))/(#\1n\2)/;
	s/(#\([^)]*\)O\([^)]*\))/(#\1o\2)/;
	s/(#\([^)]*\)P\([^)]*\))/(#\1p\2)/;
	s/(#\([^)]*\)Q\([^)]*\))/(#\1q\2)/;
	s/(#\([^)]*\)R\([^)]*\))/(#\1r\2)/;
	s/(#\([^)]*\)S\([^)]*\))/(#\1s\2)/;
	s/(#\([^)]*\)T\([^)]*\))/(#\1t\2)/;
	s/(#\([^)]*\)U\([^)]*\))/(#\1u\2)/;
	s/(#\([^)]*\)V\([^)]*\))/(#\1v\2)/;
	s/(#\([^)]*\)W\([^)]*\))/(#\1w\2)/;
	s/(#\([^)]*\)X\([^)]*\))/(#\1x\2)/;
	s/(#\([^)]*\)Y\([^)]*\))/(#\1y\2)/;
	s/(#\([^)]*\)Z\([^)]*\))/(#\1z\2)/;
	s/(#\([^)]*\) \([^)]*\))/(#\1-\2)/;
	t link-tolowercase;

	: link-allowedsymbols
	s/(#\([^)]*\)[^a-zA-Z0-9_-]\([^)]*\))/(#\1\2)/;
	t link-allowedsymbols;

	p;
}
