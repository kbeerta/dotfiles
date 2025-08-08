fpath+=($HOME/.zsh/pure)

HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=1000

export EDITOR="nvim"

alias ls="ls --color -F"

autoload -Uz compinit; compinit
autoload -Uz promptinit; promptinit

PURE_PROMPT_SYMBOL='$'
PURE_PROMPT_VIMCD_SYMBOL='%'

prompt pure

source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
