#!/bin/zsh

 package_install()
{
    if [[ "$OSTYPE" == "darwin"* ]]
    then
        if ! command -v brew &> /dev/null
        then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            # Hack Nerd Font Installation
            brew bundle
            brew tap homebrew/cask-fonts && brew install --cask font-hack-nerd-font
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]
    then
        if ! command -v apt &> /dev/null
        then
            apt update && apt upgrade -y
            apt install git vim tmux neovim curl
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
    # Remove this if using kali and import from patches
	git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

	# Tmux
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

	# Vim
	mkdir -p ~/.vim/pack/themes/start
	cd ~/.vim/pack/themes/start
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim # Plugin Manager
	mkdir ~/.vim/plugged

    # NeoVim
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # Link files
    link
}

patchfiles()
{
    mkdir ~/.patches
    cd ~/.patches

	diff ~/.dotfiles/.vimrc ~/.vimrc > ~/.patches/.vimrc.patch
	diff ~/.dotfiles/.tmux.conf ~/.tmux.conf > ~/.patches/.tmux.patch
	diff ~/.dotfiles/.zshrc ~/.zshrc > ~/.patches/.zshrc.patch
	diff ~/.dotfiles/.gitconfig ~/.gitconfig > ~/.patches/.gitconfig.patch
    diff ~/.dotfiles/.vimrc ~/.config/nvim/init.vim > ~/.patches/.nvim.patch

    backup
}

backup()
{
	mv ~/.vimrc ~/.patches/.vimrc.backup
	mv ~/.gitconfig ~/.patches/.gitconfig.backup 
	mv ~/.zshrc ~/.patches/.zshrc.backup 
	mv ~/.tmux.conf ~/.patches/.tmux.conf.backup 
    mv ~/.config/nvim/init.vim ~./.patches/.nvim.backup
}

link()
{
    # Create backups
	patchfiles

    # Link
	ln -s ~/.dotfiles/.vimrc ~/.vimrc
	ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
	ln -s ~/.dotfiles/.zshrc ~/.zshrc
	ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
    ln -s ~/.dotfiles/.vimrc ~/.config/nvim/init.vim
}

clean()
{
    rm ~/.vimrc
    rm ~/.tmux.conf
    rm ~/.zshrc
    rm ~/.gitconfig
    rm ~/.config/nvim/init.vim
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
