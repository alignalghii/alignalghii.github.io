#n
#!/bin/sed -n -f

/<h[0-9]\(\s\+id="[^"]*"\)\?>.*<\/h[0-9]>/ {
	x;
		/./ {
			/<h1/ {
				x;
					/<h1/ {
						# simpleItem
						x;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1!;
						x;
					}
					/<h2/ {
						#b parentItem
						x;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\n\1\t\2\n\1\t<ol>\n\1\t\t!;
						x;
					}
				x;
			}
			/<h2/ {
				x;
					/<h1/ {
						#b closingItem
						x;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>!;
						x;
					}
					/<h2/ {
						#b simpleItem
						x;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1!;
						x;
					}
					/<h3/ {
						#b parentItem
						x;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\n\1\t\2\n\1\t<ol>\n\1\t\t!;
						x;
					}
				x;
			}
			/<h3/ {
				x;
					/<h1/ {
						#b closingItem
						x;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;
						x;
					}
					/<h2/ {
						#b closingItem
						x;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;
						x;
					}
					/<h3/ {
						#b simpleItem
						x;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1!;
						x;
					}
					/<h4/ {
						#b parentItem
						x;
							#s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1</ol>\n\1</li>\n\1!;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\n\1\t\2\n\1\t<ol>\n\1\t\t!;
						x;
					}
				x;
			}
			/<h4/ {
				x;
					/<h1/ {
						#b closingItem
						x;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;
						x;
					}
					/<h2/ {
						#b closingItem
						x;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;
						x;
					}
					/<h3/ {
						#b closingItem
						x;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;
						x;
					}
					/<h4/ {
						#b simpleItem
						x;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1!;
						x;
					}
					/<h5/ {
						#b parentItem
						x;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\n\1\t\2\n\1\t<ol>\n\1\t\t!;
						x;
					}
				x;
			}
			/<h5/ {
				x;
					/<h1/ {
						#b closingItem
						x;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;
						x;
					}
					/<h2/ {
						#b closingItem
						x;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;
						x;
					}
					/<h3/ {
						#b closingItem
						x;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;
						x;
					}
					/<h4/ {
						#b closingItem
						x;

							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;
						x;
					}
					/<h5/ {
						#b simpleItem
						x;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1!;
						x;
					}
					/<h6/ {
						#b parentItem
						x;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\n\1\t\2\n\1\t<ol>\n\1\t\t!;
						x;
					}
				x;
			}
			/<h6/ {
				x;
					/<h1/ {
						#b closingItem
						x;

							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;
						x;
					}
					/<h2/ {
						#b closingItem
						x;

							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;
						x;
					}
					/<h3/ {
						#b closingItem
						x;

							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;
						x;
					}
					/<h4/ {
						#b closingItem
						x;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;
						x;
					}
					/<h5/ {
						#b closingItem
						x;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1!;

							s!\(\t*\)\t$!\1</ol>\n\1!;
							s!\(\t*\)\t$!\1</li>\n\1!;
						x;
					}
					/<h6/ {
						#b simpleItem
						x;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1!;
						x;
					}
					/<h7/ {
						#b parentItem
						x;
							s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\n\1\t\2\n\1\t<ol>\n\1\t\t!;
						x;
					}
				x;
			}

			# Linkify
			s!<h\([0-9]\)\(\s\+id="\([^"]*\)"\)\?>\(.*\)<\/h\([0-9]\)>!<a href="#\3">\4</a>!;

			#s!\t*\n!\n!g;
			p;

			# Push state + Remove the previous, but keep its indentation info
			x;
				H;
			x;
			s!.*\(^\|\n\)\(\t*\)\n\(<h[0-9].*</h[0-9]>\).*!\2\3!;
		}
		/^$/ {
			a <ol>

			# Beginning tab + Push state
			x;
				s/^/\t/;
				h;
			x
		}
	x;
}

$ {
	x;
		/./ {

			# closingItem

			s!\(\s*\)\(<h[0-9]\(\s\+id="[^"]*"\)\?>.*</h[0-9]>\)!\1<li>\2</li>\n\1!;

			:loop
			s!\(\t*\)\t$!\1</ol>\n\1!;
			s!\(\t*\)\t$!\1</li>\n\1!;
			t loop;

			# linkify
			s!<h\([0-9]\)\(\s\+id="\([^"]*\)"\)\?>\(.*\)</h\([0-9]\)>!<a href="#\3">\4</a>!;

			p;
		}
	x;
}
