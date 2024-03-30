setopt prompt_subst

MODE_INDICATOR="%F{yellow}Δ%f"
INSERT_MODE_INDICATOR="%F{green}Δ%f"

RED=#E67E80
GREEN=#A7C080
BLUE=#7FBBB3
ORANGE=#E69875

PROMPT="%(?.%F{$GREEN}λ %f.%F{$RED}λ!%f) %F{$ORANGE}%f "
RPROMPT="%F{$BLUE}%D{%L:%M:%S}%f %F{$ORANGE}%2~%f %F{$BLUE}%n@%m%f"
