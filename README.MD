![cover](./images/screenshot.png)

# DOTFILES

A repository that contains dotfiles for :
- [Vim](.vimrc)
- [ZSH](.zshrc)
- [Git](.gitconfig)
- [Tmux](.tmux.conf)

## Requirements

- Default shell should be Zsh
- Git, Tmux and Vim should be installed

## Installation 

**You do not have to backup your current dotfiles, This will prefix your current dotfiles with .backup** 

- Move to home directory `cd ~`
- Get this repository `git clone https://github.com/r4ksai/.dotfiles.git`
- Move into .dotfiles `cd .dotfiles`
- Make the script executable `chmod +x setup.sh`
- To install the dotfiles run `./setup.sh`

**You need to add Dracula theme to the terminal manually**

### Only linking

**Use this only to link dotfiles, this does not contain installation**

To only link the dotfiles run `./setup.sh link`

### Package Installation

To install Packages run `./setup.sh install`

### Install Font to support  Icons

**For this to take effect you need to change the terminal font to the installed font**

### Install Plugins for Vim or Nvim

**To install plugins using plugin manager run `:PlugInstall` inside vim or neovim**
