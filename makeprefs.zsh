#!/usr/bin/env zsh
for preffile in prefs/*plist; do
    ln -fv "$preffile" "$HOME/Library/Preferences/${preffile:t}"
done
