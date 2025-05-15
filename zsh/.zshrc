# Set some variables
export HYPHEN_INSENSITIVE="true"
export EDITOR='nvim'

# Add my custom theme
source ~/.theme.zsh

# Setup zsh history
export HISTFILE="$XDG_CACHE_HOME/zsh_history"
export HISTSIZE=1000000
export SAVEHIST=1000000
export HISTCONTROL=ignoredups
setopt extended_history hist_ignore_all_dups append_history inc_append_history share_history

export LANG=en_US.UTF-8

# hotkeys
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^k" kill-line
bindkey "^j" backward-word
bindkey "^k" forward-word
bindkey "^H" backward-kill-word
bindkey "^J" history-search-forward
bindkey "^K" history-search-backward
bindkey '^R' fzf-history-widget


# Aliases and custom functions
alias fixhd='sudo pkill -f fsck' # Needed to fix improperly unmounted drives on MacOS

alias g='git status'
alias gco='git checkout $(git branch -l | fzf)'
alias gcb='git commit -m "$(git branch --show-current) $1';

function audio() {
    pactl set-default-sink $(pactl list sinks | rg -oP 'Name: (.*)' --replace '$1' | fzf);
}

function ports() {
    if [ -z "$1" ]; then 
        sudo lsof -i -n
    else
        sudo lsof -i -n | rg "$1"
    fi
}

alias nt='cd ~/notes && nvim'

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# This needs to go before the bat alias
if command -v wal &> /dev/null; then
    (cat ~/.cache/wal/sequences &)
    source ~/.cache/wal/colors-tty.sh
fi

if command -v fzf &>/dev/null; then
    source <(fzf --zsh)
    export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
    export FZF_DEFAULT_OPTS="--height 50% --layout=default --border"
fi

if command -v eza &>/dev/null; then
    alias ls="eza --oneline --long --color=always"
fi

if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
    alias cd="z"
fi

if command -v bat &>/dev/null; then
    alias cat="bat"
fi

if command -v nvim &>/dev/null; then
    export MANPAGER="nvim +Man!"
fi

if command -v yazi &>/dev/null; then
    function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
    }
fi

# Add a .local.zshrc file to overwrite these settings and add aliases on a per environment basis
if [[ -f $HOME/.local.zshrc ]]; then
    source $HOME/.local.zshrc
fi

# Local scripts
if [[ ! -d ~/.local/bin ]]; then
    mkdir -p ~/.local/bin
fi

export PATH=$PATH:~/.local/bin
export PATH=$PATH:/var/lib/snapd/snap/bin

# Hotkeys
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
autoload -U colors && colors
_comp_options+=(globdots)

#################################################
### Below here is for env variables for tools ###
#################################################

fpath+=~/.zfunc

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
if command -v go &> /dev/null; then
    export GOPATH=~/.go
    export PATH=$PATH:~/.go/bin
fi

