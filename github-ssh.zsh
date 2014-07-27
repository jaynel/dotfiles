#!/usr/bin/env zsh

yes "\n" | ssh-keygen -t rsa -C "th0114nd@gmail.com" -f ~/.ssh/id_rsa
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
pbcopy < ~/.ssh/id_rsa.pub
