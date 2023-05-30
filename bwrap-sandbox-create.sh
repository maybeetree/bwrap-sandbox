#!/bin/sh
#
#This is free and unencumbered software released into the public domain.
#
#Anyone is free to copy, modify, publish, use, compile, sell, or
#distribute this software, either in source code form or as a compiled
#binary, for any purpose, commercial or non-commercial, and by any
#means.
#
#In jurisdictions that recognize copyright laws, the author or authors
#of this software dedicate any and all copyright interest in the
#software to the public domain. We make this dedication for the benefit
#of the public at large and to the detriment of our heirs and
#successors. We intend this dedication to be an overt act of
#relinquishment in perpetuity of all present and future rights to this
#software under copyright law.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
#IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
#OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
#ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
#OTHER DEALINGS IN THE SOFTWARE.
#
#For more information, please refer to <http://unlicense.org/>


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

