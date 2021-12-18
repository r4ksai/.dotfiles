#!/bin/zsh

setup()
{
    # Install Packages
    package_install
  
	# Oh-My-Zsh
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

	# Tmux
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

	# Vim
	mkdir -p ~/.vim/pack/themes/start
	cd ~/.vim/pack/themes/start
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim # Plugin Manager
	mkdir ~/.vim/plugged
    ## Install dracula mannually - change this to be added in the plugin itself
	git clone https://github.com/dracula/vim.git dracula

    # NeoVim
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # Link files
    link
}

patchfiles()
{
    mkdir ~/.patches
    cd ~/.patches
    # Todo: Check if exists and if does diff and patch into patches folder
	diff ~/.dotfiles/.vimrc ~/.vimrc > ~/.patches/.vimrc.patch
	diff ~/.dotfiles/.tmux.conf ~/.tmux.conf > ~/.patches/.tmux.patch
	diff ~/.dotfiles/.zshrc ~/.zshrc > ~/.patches/.zshrc.patch
	diff ~/.dotfiles/.gitconfig ~/.gitconfig > ~/.patches/.gitconfig.patch
    diff ~/.dotfiles/.vimrc ~/.config/nvim/init.vim > ~/.patches/.nvim.patch
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

package_install()
{
    if [[ "$OSTYPE" == "darwin"* ]]
    then
        if ! command -v brew &> /dev/null
        then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
            brew bundle
    elif [[ "$OSTYPE" == "linux-gnu"* ]]
    then
        if ! command -v apt &> /dev/null
        then
            apt update && apt upgrade -y
            apt install git vim tmux neovim curl
        fi
    fi
}

if [[ $1 = "link" ]]
then
	link
elif [[ $1 = "install" ]]
then
    package_install
else
	setup
fi
