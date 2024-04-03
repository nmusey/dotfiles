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
        branchPrompt="󰘬 $vcs_info_msg_0_" 
    else
        branchPrompt='󱓌'
    fi

    print -v 'psvar[1]' -Pr -- $branchPrompt
}

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats "%b"
zstyle ':vcs_info:git:*' actionformats "(%a) %b"
setopt prompt_subst


PROMPT="%F{$BLUE}%D{%L:%M}%f %(?.%F{$GREEN}λ %f.%F{$RED}λ!%f) %F{$ORANGE}%f "
RPROMPT="%F{$ORANGE}%2~%f %F{$BLUE}%n%f %F{$ORANGE}%v%f"
