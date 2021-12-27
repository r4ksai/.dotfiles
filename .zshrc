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
)
if [[ "$OSTYPE" == "linux-gnu"* ]]
then
    if lsb_release -a | grep -Fxq "Kali"
    then
        plugins=( 
          git
          z
          tmux
          colored-man-pages
          colorize
          web-search
        )
    fi
fi

# Path Variable
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Langauge
export LANG=en_US.UTF-8

# Color
export TERM=screen-256color

# Default Editor
export EDITOR='vim'

# Source
source $ZSH/oh-my-zsh.sh
# Source prev rc

# Alias 
alias cl="clear"
alias l="exa --icons"
alias ls="l" # For acessing ls type \ls
alias ll="exa -lg --icons"
alias la="exa -lga --icons"
alias lt="l --tree --level=2"
alias llt="ll --tree --level=2"
alias lat="la --tree --level=2"
