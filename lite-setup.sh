#!/bin/bash

cd ~

sudo apt install -y git vim curl exa peco fzf ripgrep bat neovim python3-pip zsh wget

mkdir -p ~/.config/nvim/undo
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
pip3 install --user pynvim

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

git clone https://github.com/r4ksai/.dotfiles.git

mv .dotfiles/.inputrc .
mv .dotfiles/.zshrc .
mv .dotfiles/nvim/* .config/nvim/.

echo "en_US.UTF-8 UTF-8" | sudo tee /etc/locale.gen
sudo locale-gen

