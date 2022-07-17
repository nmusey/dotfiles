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
source theme.zsh_theme



# Load plugins with Antidote
[[ -e ~/.antidote ]] || git clone https://github.com/mattmc3/antidote.git ~/.antidote
. ~/.antidote/antidote.zsh
antidote load



# Aliases and custom functions
function fix_harddrive() {
	sudo pkill -f fsck;
}

alias python=python3
alias py=python3
alias pip=pip3

alias vim=nvim
