#!/bin/zsh

setup()
{
	# Oh-My-Zsh
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
	ln -s ~/.dotfiles/.zshrc ~/.zshrc

	# Git
	ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

	# Tmux
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

	# Vim
	mkdir -p ~/.vim/pack/themes/start
	cd ~/.vim/pack/themes/start
	git clone https://github.com/dracula/vim.git dracula
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim # Plugin Manager
	mkdir ~/.vim/plugged
	ln -s ~/.dotfiles/.vimrc ~/.vimrc

    # NeoVim

    ln -s ~/.dotfiles/.vimrc ~/.config/nvim/init.vim
}

link()
{
	backup
	ln -s ~/.dotfiles/.vimrc ~/.vimrc
	ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
	ln -s ~/.dotfiles/.zshrc ~/.zshrc
	ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
    ln -s ~/.dotfiles/.vimrc ~/.config/nvim/init.vim
}

backup()
{
	mv ~/.vimrc ~/.vimrc.backup
	mv ~/.gitconfig ~/.gitconfig.backup 
	mv ~/.zshrc ~/.zshrc.backup 
	mv ~/.tmux.conf ~/.tmux.conf.backup 
}


if [[ $1 = "link" ]]
then
	link
elif [[ $1 = "brew" ]]
then
    brew bundle --file Brew
else
	setup
fi
