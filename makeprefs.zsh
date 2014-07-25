#!/usr/bin/env zsh
SETOPT EXTENDED_GLOB
for preffile in prefs/*plist; do
    ln -fvs "$preffile" "$HOME/Library/Preferences/${preffile:t}"
done
