# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins 
plugins=( 
  command-not-found
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  # fast-syntax-highlighting
  # zsh-autocomplete
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
export SHELL='/bin/zsh'

# Color
export TERM=xterm-256color

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
alias yz="yazi"
alias y="yarn"
alias yd="yarn dev"
alias gcol="gb | peco | xargs git checkout"

# Local binary files
export PATH="$HOME/.local/bin:$PATH"

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# FZF
eval "$(fzf --zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
