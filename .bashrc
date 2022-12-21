# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

# Vim Mode
set -o vi

export OSH="$HOME/.oh-my-bash"

# Theme
OSH_THEME="candy"
OMB_USE_SUDO=true

# Completions 
completions=(
  system
  git
  composer
  ssh
)

# Aliases 
aliases=(
  general
)

# Plugins 
plugins=(
  git
  bashmarks
)

# Path Variable
export PATH=$HOME/.dotfiles/Scripts:$PATH

# Langauge
export LANG=en_US.UTF-8

# Color
export TERM=screen-256color

# Default Editor
export EDITOR='vim'

# Source
source "$OSH"/oh-my-bash.sh

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
