# Zsh Configuration
#
# By Nick Musey



# Set some variables
export HYPHEN_INSENSITIVE="true"
export EDITOR='nvim'



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

alias ls='exa'
alias l='exa -al'

alias clip='xclip -sel clip'

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

# pnpm
export PNPM_HOME="/home/nick/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
