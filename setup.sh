#!/bin/zsh
# FIXME :- Change the linking path to a dynamic path
# FIXME :- Create a function to backup pre-existing dotfiles and delete 
# FIXME :- Change the dotfile permissions
setup()
{
	# Oh-My-Zsh
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
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

if [[ $1 = "link" ]]
then
	link
else
	setup
fi
