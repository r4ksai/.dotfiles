# Theme
ZSH_THEME="candy"

# Plugins 
plugins=( 
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  z
  tmux
  colored-man-pages
  colorize
  web-search
  vi-mode
)

# Path Variable
export PATH=$HOME/.dotfiles/Scripts:$PATH

source $HOME/.dracula-syntax-highlighting.sh

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Langauge
export LANG=en_US.UTF-8

# Color
export TERM=screen-256color

# Default Editor
export EDITOR='nvim'

# Source
source $ZSH/oh-my-zsh.sh

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# unsetopt BEEP

# Alias 
alias cl="clear"
alias l="exa --icons"
alias ls="l" # For acessing ls type \ls
alias ll="exa -lg --icons"
alias la="exa -lga --icons"
alias lld="ll --group-directories-first"
alias lad="ll --group-directories-first"
alias lt="l --tree --level=2"
alias llt="ll --tree --level=2"
alias lat="la --tree --level=2"
alias v="nvim"
alias nv="nvim"
alias gcol="gb | peco | xargs git checkout"
