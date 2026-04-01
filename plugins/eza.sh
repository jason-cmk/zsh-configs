# ---- Eza (better ls) -----
export EZA_CONFIG_DIR="${EZA_CONFIG_DIR:-$HOME/.config/eza}"

alias ls="eza -a --icons=always --colour=always --level 1"
