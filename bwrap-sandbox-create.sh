#!/bin/sh

BWRAP_SANDBOX_TEMPLATE="$(dirname "$(realpath "$0")")/template"

test -d "$BWRAP_SANDBOX_TEMPLATE" || {
	echo \
		"Could not find template directory at " \
		"'$BWRAP_SANDBOX_TEMPLATE'."
	exit 1
}

# Check the number of positional arguments
test "$#" -eq 2 || {
    echo "Usage: $0 <Absolute path to install directory> <path to executable, relative to install directory>"
    exit 1
}

INSTALLDIR="$(realpath "$1")"
EXECUTABLE="$2"

test -d "$INSTALLDIR" || {
	echo \
		"Could not find install directory at " \
		"'$INSTALLDIR'."
	exit 1
}

test -f "$INSTALLDIR/$EXECUTABLE" || {
	echo \
		"Could not find executable at " \
		"'$INSTALLDIR/$EXECUTABLE'."
	exit 1
}

cp -r "$BWRAP_SANDBOX_TEMPLATE" "$INSTALLDIR.bwrap-sandbox"
cp -r "$INSTALLDIR" "$INSTALLDIR.bwrap-sandbox/homedir/"
sed -i "s|HERE=.*|HERE=\"$INSTALLDIR.bwrap-sandbox\"|" \
	"$INSTALLDIR.bwrap-sandbox/run.sh"
sed -i "s|EXECUTABLE=.*|EXECUTABLE=\"$(basename "$INSTALLDIR")/$EXECUTABLE\"|" \
	"$INSTALLDIR.bwrap-sandbox/run.sh"

