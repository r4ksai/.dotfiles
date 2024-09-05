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

# Language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8  

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
alias l="lsd"
alias ls="l" # For accessing ls type \ls
alias la="lsd -a"
alias ll="lsd -lg"
alias lla="ll -a"
alias lld="ll --group-directories-first"
alias lad="ll --group-directories-first"
alias lt="l --tree --depth=2"
alias llt="ll --tree --depth=2"
alias lat="la --tree --depth=2"
alias v="nvim"
alias nv="nvim"
alias gcol="gb | peco | xargs git checkout"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
