#!/bin/bash

 package_install()
{
	if [[ "$OSTYPE" == "darwin"* ]]
	then
		if ! command -v brew &> /dev/null
		then
			/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		fi
        export PATH=/opt/homebrew/bin:$PATH
        brew bundle
    elif [[ "$OSTYPE" == "linux-gnu"* ]]
    then
        sudo apt update -qq && sudo apt install git vim tmux neovim curl exa fzf ripgrep bat kitty -y qq
    fi
}

setup()
{
	# Install Packages
	package_install
  
    # if ! (command -v lsb_release && lsb_release -a 2>/dev/null | grep -q "Kali")
    # then
    #     git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
    #     git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    # fi

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
    mkdir -p ~/.config/nvim/undo
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	# Link files
	link_files
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

link_files()
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
    link_files
elif [[ $1 = "install" ]]
then
    package_install
elif [[ $1 = "clean" ]]
then
    clean
else
	setup
fi
