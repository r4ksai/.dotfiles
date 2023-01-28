![cover](./images/screenshot.png)

# DOTFILES

A repository that contains dotfiles for :

- [Vim](.vimrc)
- [ZSH](.zshrc)
- [Git](.gitconfig)
- [Tmux](.tmux.conf)

## Requirements

- Git, Tmux and Vim should be installed

## Installation

**You do not have to backup your current dotfiles, This will prefix your current dotfiles with .backup**

- Move to home directory `cd ~`
- Get this repository `git clone https://github.com/r4ksai/.dotfiles.git`
- Move into .dotfiles `cd .dotfiles`
- To install the dotfiles run `./setup.sh`

> For mac users **You'll need to add brew environment variables and brew bins to path  in.zprofile** or **run the command below**
`echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile`

>> **You need to add Dracula theme to the terminal manually**
Download it from https://draculatheme.com

### Only linking

**Use this only to link dotfiles, this does not contain installation**

To only link the dotfiles run the installation script and choose linking option

### Package Installation

To install Packages run the installation script and choose install

### Install Font to support Icons

**For this to take effect you need to change the terminal font to the installed font**

### Install Plugins for Vim or Nvim

**To install plugins using plugin manager run `:PlugInstall` inside vim or neovim**

### Remove dotfiles

To remove dotfiles run the script and select the option to clean
