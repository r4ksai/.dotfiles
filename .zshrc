# Powerlevel10k instant prompt — must stay near the top
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ── Oh My Zsh ─────────────────────────────────────────────────────────────────
ZSH_THEME="powerlevel10k/powerlevel10k"
export ZSH="$HOME/.oh-my-zsh"

plugins=(
  command-not-found
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

source $ZSH/oh-my-zsh.sh
source $HOME/.dracula-syntax-highlighting.sh

# ── Environment ───────────────────────────────────────────────────────────────
export PATH="$HOME/.dotfiles/scripts:$HOME/.local/bin:/opt/homebrew/bin:$PATH"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export SHELL='/bin/zsh'
export EDITOR='nvim'

# ── History ───────────────────────────────────────────────────────────────────
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups \
       hist_save_no_dups hist_find_no_dups

# ── Aliases ───────────────────────────────────────────────────────────────────
alias cl="clear"

# ls
alias l="lsd"
alias ls="l"            # use \ls for the real ls
alias la="lsd -a"
alias ll="lsd -lg"
alias lla="ll -a"
alias lld="ll --group-directories-first"
alias lt="l --tree --depth=2"
alias llt="ll --tree --depth=2"
alias lat="la --tree --depth=2"
alias lt3="l --tree --depth=3"
alias llt3="ll --tree --depth=3"
alias lat3="la --tree --depth=3"
alias lt4="l --tree --depth=4"
alias llt4="ll --tree --depth=4"
alias lat4="la --tree --depth=4"
alias lt5="l --tree --depth=5"
alias llt5="ll --tree --depth=5"
alias lat5="la --tree --depth=5"

# Editors
alias v="nvim"
alias nv="nvim"
alias yz="yazi"
alias cat="bat"

# Yarn
alias y="yarn"
alias yd="yarn dev"

# Misc
alias gcol="gb | peco | xargs git checkout"
alias weather="curl wttr.in"

# ── Functions ─────────────────────────────────────────────────────────────────
copycat() {
  local CAT_CMD CLIP
  CAT_CMD=$(command -v cat)

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

  if [[ -t 0 ]]; then
    (( $# == 0 )) && { echo "Usage: copycat file..." >&2; return 1; }
    "$CAT_CMD" -- "$@" | eval "$CLIP"
  else
    eval "$CLIP"
  fi
}

# MQTT live topic viewer
mqttsub() {
  mosquitto_sub -h "$1" -t "#" -v | gawk '
  function color(v){
    if(v=="ALIVE"||v=="ON"||v=="CLEAR")     return "\033[32m"v"\033[0m"
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

cpcat() {
    if [ ! -f "$1" ]; then
        echo "File not found: $1"
        return 1
    fi

    if command -v pbcopy >/dev/null 2>&1; then
        pbcopy < "$1"
    elif command -v wl-copy >/dev/null 2>&1; then
        wl-copy < "$1"
    elif command -v xclip >/dev/null 2>&1; then
        xclip -selection clipboard < "$1"
    elif command -v xsel >/dev/null 2>&1; then
        xsel --clipboard --input < "$1"
    else
        echo "No clipboard utility found"
        return 1
    fi

    echo "Copied $1"
}

# ── Tools ─────────────────────────────────────────────────────────────────────
eval "$(fzf --zsh)"
command -v rbenv &>/dev/null && eval "$(rbenv init -)"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
