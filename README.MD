# DOTFILES

A repository that contains dotfiles for :
- Vim
- ZSH
- Git
- Tmux

## Requirements

- Default shell should be Zsh
- Git, Tmux and Vim should be installed

## Installation 

**You do not have to backup your current dotfiles**
**This will prefix your current dotfiles with .backup** 

- Move to home directory `cd ~`
- Get this repository `git clone https://github.com/r4ksai/.dotfiles.git`
- Move into .dotfiles `cd .dotfiles`
- Make the script executable `chmod +x setup.sh`
- To install the dotfiles run `./setup.sh`

### Only linking

**Use this only to link dotfiles, this does not contain installation**
To only link the dotfiles run `./setup.sh link`

