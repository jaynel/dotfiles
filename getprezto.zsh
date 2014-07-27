#!/usr/bin/env zsh
if [ ! -d ~/.zprezto/.git ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git \
        "${ZDOTDIR:-$HOME}/.zprezto"
    setopt EXTENDED_GLOB
    for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
        ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    done
    chsh -s /bin/zsh tim
else
	cd ~/.zprezto && git pull && git submodule --init --recursive
fi
