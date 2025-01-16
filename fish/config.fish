if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting ""
set -gx TERM xterm-256color

set -g theme_color_scheme terminal-dark
#set -g fish_prompt_pwd_dir_length 1
set -g fish_vi_key_bindings 1
#set -g theme_display_user yes
#set -g theme_hide_hostname no
#set -g theme_hostname always

# Alias 
alias cl clear
alias l lsd
alias ls l # For accessing ls type \ls
alias la "lsd -a"
alias ll "lsd -lg"
alias lla "ll -a"
alias lld "ll --group-directories-first"
alias lad "ll --group-directories-first"
alias lt "l --tree --depth=2"
alias llt "ll --tree --depth=2"
alias lat "la --tree --depth=2"
alias v nvim
alias nv nvim
alias gcol "gb | peco | xargs git checkout"

set -gx EDITOR nvim

set -g FZF_PREVIEW_FILE_CMD "bat --style=numbers --color=always --line-range :500"
set -g FZF_LEGACY_KEYBINDINGS 0
