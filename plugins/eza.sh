# ---- Eza (better ls) -----
# eza only reads $EZA_CONFIG_DIR/theme.yml, so we point it at one of the
# per-mode directories (light = catppuccin latte by default, dark = catppuccin
# mocha by default). Drop a different palette into either dir to swap themes.
if [[ "$LIGHT_SWITCH" == "0" ]]; then
  export EZA_CONFIG_DIR="$HOME/.config/eza/dark"
else
  export EZA_CONFIG_DIR="$HOME/.config/eza/light"
fi

alias ls="eza -a --icons=always --colour=always --level 1"
