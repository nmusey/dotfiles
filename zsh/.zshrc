# Zsh Configuration
#
# By Nick Musey



# Set some variables
HYPHEN_INSENSITIVE="true"

if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else
	export EDITOR='nvim'
fi



# Add my custom theme
source ~/theme.zsh_theme



# Load plugins with Antidote
autoload -Uz compinit
compinit
[[ -e ~/.antidote ]] || git clone https://github.com/mattmc3/antidote.git ~/.antidote
. ~/.antidote/antidote.zsh
antidote load



# Aliases and custom functions
alias fixhd='sudo pkill -f fsck'

alias python='python3'
alias py='python3'
alias pip='pip3'

alias vim='nvim'

alias ip='curl ifconfig.me'

alias ls='exa'
alias l='exa -al'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias g='git status'
alias gd='git difftool'


# Add path variables
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



# Add a local.zshrc file to overwrite these settings and add aliases on a per environment basis
if [[ -f ~/local.zshrc ]]; then
    source ~/local.zshrc
fi


if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
