#!/usr/bin/env zsh

ssh-keygen -t rsa -C "th0114nd@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
pbcopy < ~/.ssh/id_rsa.pub
