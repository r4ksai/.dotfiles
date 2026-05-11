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
  vi-mode
)

source "$ZSH/oh-my-zsh.sh"

# ── Environment ───────────────────────────────────────────────────────────────
export PATH="$HOME/.dotfiles/scripts:$HOME/.local/bin:$PATH"
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

# ls — best available: eza > lsd > plain ls
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

# cat — Ubuntu ships bat as batcat
command -v bat    &>/dev/null && alias cat="bat"
command -v batcat &>/dev/null && alias cat="batcat"

# Editors
alias v="nvim"
alias nv="nvim"

# Navigation
alias ...="../.."
alias ....="../../.."
alias md='mkdir -p'
alias _='sudo '

# Git
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
alias gcol="gb | peco | xargs git checkout"

# Misc
alias weather="curl wttr.in"

# ── Functions ─────────────────────────────────────────────────────────────────
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

# ── Tools ─────────────────────────────────────────────────────────────────────
eval "$(fzf --zsh)" 2>/dev/null || true

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
