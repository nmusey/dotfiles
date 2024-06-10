RED=#E67E80
GREEN=#A7C080
BLUE=#7FBBB3
ORANGE=#E69875
YELLOW=#DBBC7F

MODE_INDICATOR="%F{$YELLOW}Δ%f"
INSERT_MODE_INDICATOR="%F{$GREEN}Δ%f"

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


PROMPT="%F{$ORANGE}%D{%L:%M}%f  %F{$BLUE}%n@%m%f   %F{$ORANGE}%2~%f   %F{$GREEN}%v%f$NEWLINE%(?.%F{$GREEN}λ %f.%F{$RED}λ!%f) "
RPROMPT="$NEWLINE$NEWLINE"

if command -v fastfetch &> /dev/null; then
    print ""
    fastfetch -l small --structure "DateTime:Break:Separator:Title:Separator:OS:PublicIP"
fi
