export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="theunraveler"

HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode auto      # update automatically without asking

plugins=(
	git
	colored-man-pages
	safe-paste
)

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else
	export EDITOR='nvim'
fi

PATH="/usr/local/bin:$PATH"
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

function fix_harddrive() {
	sudo pkill -f fsck;
}


# Aliases
alias python=python3
alias py=python3
alias pip=pip3

alias vim=nvim
alias ls=ls -al
