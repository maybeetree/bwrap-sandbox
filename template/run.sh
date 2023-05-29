#!/bin/sh

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

