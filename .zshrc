[[ -n "$ZPROF" ]] && zmodload zsh/zprof

# ---------------------------------------------------------------------------
# Bare zsh setup (no oh-my-zsh). Backup: .zshrc.bak-omz-YYYYMMDD
# ---------------------------------------------------------------------------

# ---- History ----
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=10000
setopt EXTENDED_HISTORY SHARE_HISTORY HIST_IGNORE_DUPS \
       HIST_IGNORE_SPACE HIST_VERIFY HIST_REDUCE_BLANKS

# ---- Behaviour ----
setopt AUTO_CD INTERACTIVE_COMMENTS NO_BEEP PROMPT_SUBST
bindkey -e
autoload -Uz colors && colors

# ---- Completion ----
# zsh-autocomplete must be sourced *before* compinit; it runs compinit itself.
# See plugins/zsh-autocomplete.sh — sourced here so it owns compinit and we
# don't double-audit. Recompile its dump in the background if stale.
autoload -Uz compinit
source $ZDOTDIR_JASON/plugins/zsh-autocomplete.sh
_zcompdump=${ZDOTDIR:-$HOME}/.zcompdump-${HOST}-${ZSH_VERSION}
{ [[ -s $_zcompdump && ( ! -s $_zcompdump.zwc || $_zcompdump -nt $_zcompdump.zwc ) ]] && zcompile -R -- $_zcompdump } &!
unset _zcompdump

# ---- Prompt (af-magic clone using native vcs_info) ----
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{214}*%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{214}*%f'
zstyle ':vcs_info:git:*' formats       ' %F{75}(%F{78}%b%u%c%F{75})%f'
zstyle ':vcs_info:git:*' actionformats ' %F{75}(%F{78}%b|%a%u%c%F{75})%f'
precmd() { vcs_info }

function _afm_dashes() { print -n ${(l:COLUMNS::-:)} }
PS1='%F{237}$(_afm_dashes)%f
%F{32}%~${vcs_info_msg_0_} %F{105}%(!.#.»)%f '
RPS1='%(?..%F{red}%? ↵%f) %F{237}%n@%m%f'

# ---- Editor ----
export EDITOR='nvim'
export ARCHFLAGS="-arch x86_64"

# ---- Edit current command line with $EDITOR via Ctrl-E ----
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# ---- Aliases ----
alias xdev='zsh ~/xdev.sh'

# ---- Plugins ----
# zsh-autocomplete is sourced earlier (before compinit). See top of file.
# bun is configured via ~/.zshrc (PATH + completions); no plugin file needed.
# Plugins are sourced from .zwc bytecode if available — recompiled in the
# background below when stale.
for _plugin in bat delta eza fzf wsl-clipboard-fix zoxide gafz; do
  source $ZDOTDIR_JASON/plugins/$_plugin.sh
done
unset _plugin

# Background-recompile any plugin whose .zwc is missing or stale
{
  for _p in $ZDOTDIR_JASON/plugins/*.sh; do
    [[ ! -s $_p.zwc || $_p -nt $_p.zwc ]] && zcompile -R -- $_p
  done
} &!

[[ -n "$ZPROF" ]] && zprof
