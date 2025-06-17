color1=#A7C080
color2=#7FBBB3
color3=#E69875
color4=#E67E80
color5=#DBBC7F

[[ -f "$HOME/.cache/wal/colors.sh" ]] && source "$HOME/.cache/wal/colors.sh"

MODE_INDICATOR="%F{$color5}Δ%f"
INSERT_MODE_INDICATOR="%F{$color2}Δ%f"

autoload -Uz vcs_info
precmd() {
    vcs_info
    psvar=()

    local branchPrompt
    if [ -n "$vcs_info_msg_0_" ]; then 
        branchPrompt="$vcs_info_msg_0_" 
    else
        branchPrompt=''
    fi

    print -v 'psvar[1]' -Pr -- $branchPrompt
    print ""
}

NEWLINE=$'\n'

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats "%b"
zstyle ':vcs_info:git:*' actionformats "(%a) %b"
setopt prompt_subst


PROMPT="%F{$color1}%D{%L:%M}%f  %F{$color3}%n@%m%f   %F{$color1}%2~%f   %F{$color2}%v%f$NEWLINE%(?.%F{$color2}λ %f.%F{$color4}λ!%f) "
RPROMPT="$NEWLINE$NEWLINE"

if command -v fastfetch &> /dev/null; then
    print ""
    fastfetch -l small --structure "DateTime:Separator:Title:Colors:Separator:OS"
fi
