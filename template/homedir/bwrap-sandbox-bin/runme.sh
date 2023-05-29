#!/bin/sh

test -d ~/bwrap-sandbox-bin && {
	echo \
		"Found ~/bwrap-sandbox-bin, likely running in sandbox." \
		"Now edit this script to launch the executable that you " \
		"want to sandbox."
} || {
	echo "Didn't find ~/bwrap-sandbox-bin, likely NOT running in sandbox"
}

