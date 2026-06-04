color1=#A7C080
color2=#7FBBB3
color3=#E69875
color4=#E67E80
color5=#DBBC7F

if [[ -f "$HOME/.cache/wal/colors.sh" ]]; then
    set -a  # export all variables defined below to child processes
    source "$HOME/.cache/wal/colors.sh"
    set +a
fi

STATUS_INDICATOR="%(?.%F{$color1}>%f.%F{$color3}>%f)"
NEWLINE=$'\n'

git_prompt() {
    local branch
    branch=$(git branch --show-current 2>/dev/null)
    [[ -n $branch ]] && echo "[%F{$color3}$branch%f]"
}

setopt prompt_subst
export TRANSIENT_RPROMPT=true
export PROMPT='[%F{$color2}%2~%f] $STATUS_INDICATOR '
export RPROMPT='$(git_prompt) %F{$color1}%n%f@%F{$color1}%m%f'
