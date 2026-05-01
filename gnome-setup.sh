#!/bin/bash

# Windows
gsettings set org.gnome.mutter attach-modal-dialogs false
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer', 'autoclose-xwayland']"
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,close"
gsettings set org.gnome.desktop.wm.preferences titlebar-font "Noto Sans Bold 11"

# Middle-click paste
gsettings set org.gnome.desktop.interface gtk-enable-primary-paste true

# Desktop fonts
gsettings set org.gnome.desktop.interface font-name "Noto Sans Medium 11"
gsettings set org.gnome.desktop.interface document-font-name "Noto Sans Medium 11"
gsettings set org.gnome.desktop.interface monospace-font-name "JetBrains Mono Regular 11"
gsettings set org.gnome.desktop.wm.preferences titlebar-font "Noto Sans Bold 11"

# Freetype antialiasing
gsettings set org.gnome.desktop.interface font-antialiasing "rgba"
gsettings set org.gnome.desktop.interface font-hinting "slight"
echo "Xft.lcdfilter: lcddefault" > ~/.Xresources

# Theme
gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3"
gsettings set org.gnome.desktop.interface icon-theme "Papirus"

# Input sources
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'ru')]"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Shift>Alt_L']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Alt>Shift_L']"

# Disable default action on Win+P shortcut
gsettings set org.gnome.mutter.keybindings switch-monitor "['XF86Display']"

# Turn screen On/Off with Win+P shortcut
KEY_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
MEDIA_KEYS="org.gnome.settings-daemon.plugins.media-keys"
gsettings set $MEDIA_KEYS custom-keybindings "['$KEY_PATH']"
gsettings set $MEDIA_KEYS.custom-keybinding:$KEY_PATH name "Screen On/Off"
gsettings set $MEDIA_KEYS.custom-keybinding:$KEY_PATH command "/bin/sh -c '[ \$(light -G) = 0.00 ] && light -I || (light -O; light -S 0)'"
gsettings set $MEDIA_KEYS.custom-keybinding:$KEY_PATH binding "<Super>P"
