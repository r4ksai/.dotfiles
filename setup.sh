#!/bin/zsh

# Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ln -s .zshrc ~/.zshrc

# Git
ln -s .gitconfig ~/.gitconfig

# Tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s .tmux.conf ~/.tmux.conf

# Vim
mkdir -p ~/.vim/pack/themes/start
cd ~/.vim/pack/themes/start
git clone https://github.com/dracula/vim.git dracula
ln -s .vimrc ~/.vimrc

