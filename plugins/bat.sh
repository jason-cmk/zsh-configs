# ---- bat (better cat) -----
alias cat="bat"

# Per-mode bat themes. Change either side independently; values must match
# names in `bat --list-themes` (e.g. "Dracula", "gruvbox-dark", "Nord").
local LIGHT_THEME="Catppuccin Latte"
local DARK_THEME="Catppuccin Mocha"

if [[ "${LIGHT_SWITCH:l}" == "off" ]]; then
  export BAT_THEME="$DARK_THEME"
else
  export BAT_THEME="$LIGHT_THEME"
fi
