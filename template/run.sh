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


# Change to full path of
# directory containing `bwrap-sandbox-homedir`
HERE="."

# Change to location of executable that you want to sandbox
# (relative to the sandboxed home directory)
EXECUTABLE="bwrap-sandbox-bin/runme.sh"

cd "$HERE"

bwrap \
 `# Core system directories` \
 --ro-bind /usr /usr \
 --symlink usr/bin /bin --symlink usr/bin /sbin \
 --symlink usr/lib /lib --symlink usr/lib /lib64 \
 --dev /dev \
 --tmpfs /var \
 --tmpfs /tmp \
 --tmpfs /run --dir /run/user/$UID \
 --ro-bind /etc /etc \
 --proc /proc \
 `# Isolated home directory` \
 --bind ./homedir $HOME \
 `# Allow to access installed themes and icons` \
 --ro-bind ~/.themes ~/.themes \
 --ro-bind ~/.icons ~/.icons \
 --ro-bind ~/.local ~/.local \
 `# Sound` \
 `#--ro-bind "$XDG_RUNTIME_DIR/pipewire-0" "$XDG_RUNTIME_DIR/pipewire-0" ` \
 --ro-bind "$XDG_RUNTIME_DIR/pulse" "$XDG_RUNTIME_DIR/pulse" \
 --ro-bind $HOME/.Xauthority $HOME/.Xauthority \
 `# X11` \
 --bind /tmp/.X11-unix/X0 /tmp/.X11-unix/X0 \
 `#--bind /run/dbus /run/dbus ` \
 `#--bind /var/lib/dbus /var/lib/dbus ` \
 --unshare-all \
 --unshare-net \
 --setenv PATH ~/bwrap-sandbox-bin:/usr/bin:~/.local/bin:/bin:/usr/local/sbin:/usr/local/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl \
 `#--setenv DBUS_SESSION_BUS_ADDRESS "unix:path=/run/user/$UID/bus" ` \
 "$EXECUTABLE"

