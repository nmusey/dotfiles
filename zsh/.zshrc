# Set some variables
export HYPHEN_INSENSITIVE="true"
export EDITOR='nvim'

# Add my custom theme
source ~/.theme.zsh

# Setup zsh history
export HISTFILE="$XDG_CACHE_HOME/zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000
export HISTCONTROL=ignoredups
setopt EXTENDED_HISTORY HIST_IGNORE_ALL_DUPS APPEND_HISTORY INC_APPEND_HISTORY SHARE_HISTORY

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

alias t='tmux-dev'
alias ta='tmux attach -t "$(tmux list-sessions | fzf | cut -d: -f1)"'
alias g='git status'
alias gco='git checkout $(git branch -l | fzf)'

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
    (command cat ~/.cache/wal/sequences &)
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

if command -v rg &>/dev/null; then
    export RIPGREP_CONFIG_PATH=~/.config/ripgrep/.ripgreprc
fi

# Add a .local.zshrc file to overwrite these settings and add aliases on a per environment basis
if [[ -f $HOME/.local.zshrc ]]; then
    source $HOME/.local.zshrc
fi

# Local scripts
if [[ -d ~/.local/bin ]]; then
    mkdir -p ~/.local/bin
fi

export PATH=$PATH:~/.local/bin

# Setup homebrew for macs
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Setup Go environment
if command -v go &> /dev/null; then
    export GOPATH=~/.go
    export PATH=$PATH:~/.go/bin
fi

