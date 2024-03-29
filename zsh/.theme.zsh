# Enable git info
autoload -Uz vcs_info
precmd_functions+=( vcs_info )
setopt prompt_subst

# Format the git string
zstyle ':vcs_info:git:*' formats '%F{5}(%b%u)%f '
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' enable git

MODE_INDICATOR="%F{yellow}Δ%f"
INSERT_MODE_INDICATOR="%F{green}Δ%f"

function vi_mode_indicator() {
    local command_exists = $(command -v vi_mode_prompt_info)
    local command_output = $vi_mode_prompt_info

    if [[ $command_exists -ne 0 ]] && [[ $command_output == "" ]];
        then return
    fi
    
    return echo "$vi_mode_prompt_info ";
}

PROMPT='%n $vi_mode_indicator%F{green}λ%f%(?. .%F{red}!%f) '
RPROMPT='%F{blue}%D{%L:%M:%S}%f | %F{green}%2~%f - %F{green}${vcs_info_msg_0_}%f'
