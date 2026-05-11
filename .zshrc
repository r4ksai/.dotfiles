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
export PATH=$HOME/.dotfiles/scripts:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export SHELL='/bin/zsh'

# Default Editor
export EDITOR='nvim'

# Source
source $ZSH/oh-my-zsh.sh

source $HOME/.dracula-syntax-highlighting.sh

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
alias cat="bat"
alias weather="curl wttr.in"

copycat() {
  # Detect real cat (ignores alias to bat)
  CAT_CMD=$(command -v cat)

  # Detect clipboard command
  if command -v pbcopy >/dev/null 2>&1; then
    CLIP="pbcopy"
  elif command -v xclip >/dev/null 2>&1; then
    CLIP="xclip -selection clipboard"
  elif command -v xsel >/dev/null 2>&1; then
    CLIP="xsel --clipboard --input"
  else
    echo "No clipboard tool found (install pbcopy, xclip, or xsel)" >&2
    return 1
  fi

  # If stdin is a terminal, use filenames
  if [[ -t 0 ]]; then
    if (( $# == 0 )); then
      echo "Usage: copycat file..." >&2
      return 1
    fi
    "$CAT_CMD" -- "$@" | eval "$CLIP"
  else
    # stdin is piped → copy directly
    eval "$CLIP"
  fi
}

# Local binary files
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
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

mqttsub() {
  mosquitto_sub -h "$1" -t "#" -v | gawk '
  function color(v){
    if(v=="ALIVE"||v=="ON"||v=="CLEAR") return "\033[32m"v"\033[0m"
    if(v=="OFFLINE"||v=="OFF"||v=="BROKEN") return "\033[31m"v"\033[0m"
    return v
  }
  {
    data[$1]=$2
    printf "\033[H\033[J"
    n = asorti(data, keys)
    for(i=1;i<=n;i++)
      printf "%-40s %s\n", keys[i], color(data[keys[i]])
  }'
}
