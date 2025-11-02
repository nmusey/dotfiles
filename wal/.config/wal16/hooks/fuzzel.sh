#!/usr/bin/env bash

colors="$HOME/.cache/wal/colors"
config="$HOME/.config/fuzzel/fuzzel.ini"

cat > "$config" <<EOF
[colors]
background=$(awk 'NR==1' $colors)ff
text=$(awk 'NR==2' $colors)ff
match=$(awk 'NR==3' $colors)ff
selection=$(awk 'NR==4' $colors)ff
selection-text=$(awk 'NR==5' $colors)ff
border=$(awk 'NR==6' $colors)ff
EOF

