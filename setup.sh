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
	ln -s ~/.dotfiles/.vimrc ~/.vimrc
}

link()
{
	ln -s ~/.dotfiles/.vimrc ~/.vimrc
	ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
	ln -s ~/.dotfiles/.zshrc ~/.zshrc
	ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
}

brew()
{
	brew install tmux
	brew install vim
	brew install htop
	brew install pyenv
	brew install nmap
	brew install openvpn
	brew install fish
	brew install npm
	brew install blender
}

backup()
{
	mv ~/.vimrc ~/.vimrc.backup
	mv ~/.gitconfig ~/.gitconfig.backup 
	mv ~/.zshrc ~/.zshrc.backup 
	mv ~/.tmux.conf ~/.tmux.conf.backup 
}

backup

if [[ $1 = "link" ]]
then
	link
elif [[ $1 = "brew" ]]
then
	brew
else
	setup
fi