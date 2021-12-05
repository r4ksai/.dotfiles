# Theme
ZSH_THEME="candy"

# Plugins 
plugins=( 
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  z
)

# Path Variable
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Langauge
export LANG=en_US.UTF-8

# Default Editor
export EDITOR='vim'

# Source
source $ZSH/oh-my-zsh.sh

# Alias 
alias cl="clear"
alias l="exa"
alias ll="exa -lg"
alias la="exa -lga"
