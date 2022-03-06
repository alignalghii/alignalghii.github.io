#!/user/bin/awk -f

/\[$/,/\]$/ {
	if (/^$/) next; # `!$0` works too
}

{print;}
