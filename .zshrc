#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# Aliases
alias gst='git status'
alias gck='git checkout'
alias gad='git add'
alias gbr='git branch'
alias gcm='git commit'
alias goln='git log --oneline --graph'
alias glast='git log -1 HEAD'
alias chrome='open -a "Google Chrome"'
alias ql='qlmanage -p 2>/dev/null'
alias rm='rm -f'
alias gpc='gpc -Wl,-no_pie,-macosx_version_min,10.9'

# Suffix aliases
alias -s py=vim -p
alias -s hs=vim -p
alias -s html=chrome
alias -s md=chrome
alias -s com=chrome
alias -s net=chrome
alias -s gov=chrome
alias -s edu/chrome

autoload -U zmv
alias mmv='noglob zmv -W'
# Convenience
function cs () {
    cd "$@" && ls
    }

defaults write org.m0k.transmission DownloadAsk -bool false
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true
defaults write org.m0k.transmission WarningDonate -bool false
defaults write org.m0k.transmission WarningLegal -bool false

export PYTHONPATH=/opt/local/lib/python2.7/site-packages
export PATH=.:$PATH
