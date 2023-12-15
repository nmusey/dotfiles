# Set some variables
export HYPHEN_INSENSITIVE="true"
export EDITOR='nvim'

# Add my custom theme
source ~/theme.zsh_theme

# Aliases and custom functions
alias fixhd='sudo pkill -f fsck' # Needed to fix improperly unmounted drives on MacOS

alias ls='exa'
alias l='exa -al'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias g='git status'
alias gd='git difftool'

# Add a local.zshrc file to overwrite these settings and add aliases on a per environment basis
if [[ -f ~/local.zshrc ]]; then
    source ~/local.zshrc
fi



#################################################
### Below here is for env variables for tools ###
#################################################

# Load plugins with Antidote
autoload -Uz compinit
compinit
[[ -e ~/.antidote ]] || git clone https://github.com/mattmc3/antidote.git ~/.antidote
. ~/.antidote/antidote.zsh
antidote load

# Add path variables
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Setup homebrew for macs
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

VI_KEYMAP=main
