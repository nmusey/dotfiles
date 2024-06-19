# Set some variables
export HYPHEN_INSENSITIVE="true"
export EDITOR='nvim'

# Add my custom theme
source ~/.theme.zsh

# Setup zsh history
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export HISTCONTROL=ignoredups
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS

# Aliases and custom functions
alias fixhd='sudo pkill -f fsck' # Needed to fix improperly unmounted drives on MacOS

alias g='git status'

function commit() {
    local branch=$(git rev-parse --abbrev-ref HEAD)
    local message="$branch $@"
    git commit -m "$message"
}

# Add a local.zshrc file to overwrite these settings and add aliases on a per environment basis
if [[ -f $HOME/local.zshrc ]]; then
    source $HOME/local.zshrc
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
unset PREFIX
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Setup homebrew for macs
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Setup .NET Core path
if [[ -e $HOME/.dotnet/tools ]]; then
    export PATH=$PATH:$HOME/.dotnet/tools
fi

# Setup Go environment
if [[ -e /usr/local/go/bin/go ]]; then
    export PATH=$PATH:/usr/local/go/bin
fi
if command -v go &> /dev/null; then
    export GOPATH=~/.go/
    export PATH=$PATH:$GOPATH/bin
fi

VI_KEYMAP=main
