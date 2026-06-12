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

lbracket='«'
rbracket='»'
separator=' - '
final='=>'

STATUS_INDICATOR="%(?.%F{$color1}$final%f.%F{$color3}$final%f)"
NEWLINE=$'\n'

git_prompt() {
    local branch
    branch=$(git branch --show-current 2>/dev/null)
    [[ -n $branch ]] && echo "$separator$lbracket%F{$color1}$branch%f$rbracket"
}

setopt prompt_subst
export TRANSIENT_RPROMPT=true
export PROMPT=' $lbracket%F{$color2}%2~%f$rbracket$(git_prompt) $STATUS_INDICATOR '
export RPROMPT='$lbracket%F{$color2}%n%f@%F{$color3}%m%f$rbracket'
