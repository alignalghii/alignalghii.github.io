#!/usr/bin/awk -f

BEGIN {
	exists_state = 0;
	tab = "\t";
	currentTabbing = 0;
}

/<h[0-9](\s+id="[^"]*")?>.*<\/h[0-9]>/ {
	if (exists_state) {
		currentLevel = level($0);
		stateLevel = level(state);
		diff = currentLevel - stateLevel;
		if (diff == 0) {
			res = simpleItem(state);
		}
		if (diff > 0) {
			res = parentItem(state);
		}
		if (diff < 0) {
			res = closingItem(state, diff);
		}
		print linkify(res);
	} else {
		print tabbing(currentTabbing++) "<ul>";
	}

	state = trim($0);
	exists_state = 1;
}

END {
	if (exists_state) {
		print linkify(closingItem(state, -level(state)+1));
		print tabbing(--currentTabbing) "</ul>";
	}
}

function linkify(txt) {
	return gensub(/<h[0-9](\s+id="([^"]*)")?>(.*)<\/h[0-9]>/, "<a href=\"#\\2\">\\3</a>", "g", txt);
}

function level(txt) {
	return gensub(/.*<h([0-9])(\s+id="[^"]*")?>.*/, "\\1", "g", txt);
}

function simpleItem(txt) {
	return tabbing(currentTabbing) "<li>" txt "</li>"
}

function parentItem(txt, n) {
	n = currentTabbing;
	currentTabbing += 2;
	return tabbing(n) "<li>\n" tabbing(n+1) txt "\n" tabbing(n+1) "<ul>";
}


function closingItem(txt, diff, i, res) {
	n = currentTabbing;
	res = simpleItem(txt);
	for (i = 0; i < -diff; i++) {
		currentTabbing--;
		res = res "\n" tabbing(currentTabbing) "</ul>";
		currentTabbing--;
		res = res "\n" tabbing(currentTabbing) "</li>";
	}
	return res;
}


function tabbing(n,  indentation, i) {
	indentation = "";
	for (i = 1; i <= n; i++)
		indentation = tab indentation;
	return indentation;
}

function trim(txt) {
	return gensub(/\s*(.*)\s*/, "\\1", "g", txt);
}
