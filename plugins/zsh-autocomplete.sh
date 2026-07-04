#! /usr/bin/bash

# https://github.com/marlonrichert/zsh-autocomplete
# Arch: sudo pacman -Syu zsh-autocomplete
# macOS: brew install zsh-autocomplete

# Hardcoded paths to avoid forking `brew --prefix` on every shell start
# (cost ~180ms). Fall back to brew lookup if the hardcoded paths are stale,
# e.g. after switching machines or if Homebrew prefix changes.
_zsh_autocomplete_plugin=
for _candidate in \
  /opt/homebrew/opt/zsh-autocomplete/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh \
  /usr/local/opt/zsh-autocomplete/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh \
  /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
do
  [[ -f "$_candidate" ]] && { _zsh_autocomplete_plugin="$_candidate"; break }
done
unset _candidate
if [[ -z "$_zsh_autocomplete_plugin" ]] && command -v brew >/dev/null 2>&1; then
  _zsh_autocomplete_plugin="$(brew --prefix zsh-autocomplete 2>/dev/null)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
  [[ -f "$_zsh_autocomplete_plugin" ]] || _zsh_autocomplete_plugin=
fi

# Debounce live autocomplete + enable completion cache (helps slow completers like git)
zstyle ':autocomplete:*' min-delay 0.3
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path ~/.zcompcache

source "$_zsh_autocomplete_plugin"
unset _zsh_autocomplete_plugin
