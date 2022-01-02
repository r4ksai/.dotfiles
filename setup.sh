#!/bin/bash

 package_install()
{
	if [[ "$OSTYPE" == "darwin"* ]]
	then
		if ! command -v brew &> /dev/null
		then
			/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
			brew bundle
		fi
	elif [[ "$OSTYPE" == "linux-gnu"* ]]
	then
		if command -v apt &> /dev/null
		then
			apt update && apt upgrade -y
			apt install git vim tmux neovim curl exa fzf ripgrep silversearcher-ag bat -y
			# Hack Nerd Font Installation
			cd /tmp
			git clone https://github.com/ryanoasis/nerd-fonts.git
			cd nerd-fonts
			./install.sh Hack
            cd ~/.dotfiles
		fi
	fi
}

setup()
{
	# Install Packages
	package_install
  
	# Oh-My-Zsh
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    
    if ! lsb_release -a 2>/dev/null | grep -q "Kali"
    then
        git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    fi

	# Tmux
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

	# Vim
	mkdir -p ~/.vim/undo
	mkdir -p ~/.vim/pack/themes/start
	cd ~/.vim/pack/themes/start
	git clone https://github.com/dracula/vim.git dracula

	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
	mkdir ~/.vim/plugged

	# NeoVim
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	# Link files
	link
}


backup()
{
	mkdir -p ~/.backups
	cd ~/.backups

    if [ -f ~/.vimrc ]; then 
        mv ~/.vimrc ~/.backups/.vimrc.backup
    fi
    if [ -f ~/.gitconfig ]; then 
        mv ~/.gitconfig ~/.backups/.gitconfig.backup 
    fi
    if [ -f ~/.zshrc ]; then 
        mv ~/.zshrc ~/.backups/.zshrc.backup 
    fi
    if [ -f ~/.tmux.conf ]; then 
        mv ~/.tmux.conf ~/.backups/.tmux.conf.backup 
    fi
    if [ -f ~/.config/nvim/init.vim ]; then 
        mv ~/.config/nvim/init.vim ~./.backups/.nvim.backup
    fi
}

link()
{
    # Create nvim directory
    mkdir -p ~/.config/nvim

    # Clean
    clean

    # Create backups
    backup

    # Link
    ln -s ~/.dotfiles/.vimrc ~/.vimrc
    ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
    ln -s ~/.dotfiles/.zshrc ~/.zshrc
    ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
    ln -s ~/.dotfiles/.vimrc ~/.config/nvim/init.vim
}

clean()
{
    # Remove Links
    if [ -L ~/.vimrc ]; then 
        rm ~/.vimrc
    fi
    if [ -L ~/.tmux.conf ]; then 
        rm ~/.tmux.conf
    fi
    if [ -L ~/.zshrc ]; then 
        rm ~/.zshrc
    fi
    if [ -L ~/.gitconfig ]; then 
        rm ~/.gitconfig
    fi
    if [ -L ~/.config/nvim/init.vim ]; then 
        rm ~/.config/nvim/init.vim
    fi
    
    # Restore Backups
    if [ -f ~/.backups/.vimrc.backup ]; then 
        mv ~/.backups/.vimrc.backup ~/.vimrc 
    fi
    if [ -f ~/.backups/.gitconfig.backup ]; then 
        mv ~/.backups/.gitconfig.backup ~/.gitconfig 
    fi
    if [ -f ~/.backups/.zshrc.backup ]; then 
        mv ~/.backups/.zshrc.backup ~/.zshrc  
    fi
    if [ -f ~/.backups/.tmux.conf.backup ]; then 
        mv ~/.backups/.tmux.conf.backup ~/.tmux.conf 
    fi
    if [ -f ~/.config/nvim/init.vim ]; then 
        mv ~./.backups/.nvim.backup ~/.config/nvim/init.vim 
    fi
}

if [[ $1 = "link" ]]
then
    link
elif [[ $1 = "install" ]]
then
    package_install
elif [[ $1 = "clean" ]]
then
    clean
else
	setup
fi
