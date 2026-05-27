#! /usr/bin/bash

# https://github.com/marlonrichert/zsh-autocomplete
# Arch: sudo pacman -Syu zsh-autocomplete
# macOS: brew install zsh-autocomplete

_zsh_autocomplete_plugin=
if command -v brew >/dev/null 2>&1; then
  _zsh_autocomplete_plugin="$(brew --prefix zsh-autocomplete 2>/dev/null)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
  [[ -f "$_zsh_autocomplete_plugin" ]] || _zsh_autocomplete_plugin=
fi
if [[ -z "$_zsh_autocomplete_plugin" ]]; then
  _zsh_autocomplete_plugin=/usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
fi

# Debounce live autocomplete + enable completion cache (helps slow completers like git)
zstyle ':autocomplete:*' min-delay 0.3
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path ~/.zcompcache

source "$_zsh_autocomplete_plugin"
unset _zsh_autocomplete_plugin
