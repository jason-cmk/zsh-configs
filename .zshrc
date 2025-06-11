# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="af-magic"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Edit line with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Xero dev setup
alias xdev='zsh ~/xdev.sh'

# My plugins
source $ZDOTDIR/plugins/bat.sh
source $ZDOTDIR/plugins/bun.sh
source $ZDOTDIR/plugins/eza.sh
source $ZDOTDIR/plugins/fzf.sh
source $ZDOTDIR/plugins/wsl-clipboard-fix.sh
source $ZDOTDIR/plugins/zoxide.sh
