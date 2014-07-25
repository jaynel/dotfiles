#!/usr/bin/env zsh
SETOPT EXTENDED_GLOB
for preffile in prefs/*plist; do
    ln -fv "$preffile" "$HOME/Library/Preferences/${preffile:t}"
done
