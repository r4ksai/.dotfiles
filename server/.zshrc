# Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  z
  colored-man-pages
  vi-mode
)

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='nvim'

source $ZSH/oh-my-zsh.sh

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# FZF
command -v fzf &>/dev/null && eval "$(fzf --zsh)"

# ls — use best available
if command -v eza &>/dev/null; then
  alias l="eza --icons"
  alias la="eza -lga --icons"
  alias ll="eza -lg --icons"
  alias lt="l --tree --level=2"
  alias llt="ll --tree --level=2"
elif command -v lsd &>/dev/null; then
  alias l="lsd"
  alias la="lsd -a"
  alias ll="lsd -lg"
  alias lt="l --tree --depth=2"
  alias llt="ll --tree --depth=2"
else
  alias l="ls --color=auto"
  alias la="ls -lah --color=auto"
  alias ll="ls -lg --color=auto"
  alias lt="ls -R"
  alias llt="ls -lgR"
fi
alias ls="l"

# cat — use bat if available
command -v bat &>/dev/null && alias cat="bat"
command -v batcat &>/dev/null && alias cat="batcat"  # Ubuntu names it batcat

# Core aliases
alias cl="clear"
alias v="nvim"
alias nv="nvim"
alias ...=../..
alias ....=../../..
alias .....=../../../..
alias _='sudo '
alias md='mkdir -p'

# Git shortcuts (common ones only)
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit -v"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gcb="git checkout -b"
alias glog="git log --oneline --decorate --graph"

# Local bin
export PATH="$HOME/.local/bin:$PATH"
