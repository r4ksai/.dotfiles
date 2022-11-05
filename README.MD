![cover](./images/screenshot.png)

# DOTFILES

A repository that contains dotfiles for :

- [Vim](.vimrc)
- [ZSH](.zshrc)
- [Git](.gitconfig)
- [Tmux](.tmux.conf)

## Requirements

- Default shell should be Zsh
- Oh my Zsh
- Git, Tmux and Vim should be installed

## Installation

**You do not have to backup your current dotfiles, This will prefix your current dotfiles with .backup**

- Install Oh my Zsh **Run setup.sh and select installation for oh my zsh**
- Move to home directory `cd ~`
- Get this repository `git clone https://github.com/r4ksai/.dotfiles.git`
- Move into .dotfiles `cd .dotfiles`
- To install the dotfiles run `./setup.sh`

> For mac users **You'll need to add brew environment variables and brew bins to path  in.zprofile** or **run the command below**
`echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile`

>> **You need to add Dracula theme to the terminal manually**

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

## Todo

- [ ] Add script for kali linux and bash
- [ ] Add option to choose between zsh, bash and fish
- [ ] Fix vimrc to install less plugins if environment variable is specified
- [ ] Add conditional code in vimrc with environment variable
