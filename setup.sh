#!/bin/bash

 package_install()
{
	if [[ "$OSTYPE" == "darwin"* ]]
	then
		if ! command -v brew &> /dev/null
		then
            echo 'Installing Homebrew'
			/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		fi
        export PATH=/opt/homebrew/bin:$PATH
        echo 'Installing brew bundle'
        brew bundle
    elif [[ "$OSTYPE" == "linux-gnu"* ]]
    then
        echo 'Updating'
        sudo apt update -qq
        echo 'Installing'
        sudo apt install git vim tmux curl exa fzf ripgrep bat -y -qq
        if [[ "$DOTINSTALL" != "server" ]]
        then
            sudo apt install neovim kitty nodejs npm -y -qq
        fi
    fi
}

setup()
{
	# Install Packages
	package_install

	# Tmux
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

	# Vim
	mkdir -p ~/.vim/undo
	mkdir -p ~/.vim/pack/themes/start
	cd ~/.vim/pack/themes/start
	git clone https://github.com/dracula/vim.git dracula

	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
	mkdir ~/.vim/plugged

    if [[ "$DOTINSTALL" != "server" ]]
    then
        npm install -g typescript typescript-language-server diagnostic-languageserver pyright prettier

        # NeoVim
        mkdir -p ~/.config/nvim/undo
        curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        pip3 install --user pynvim
    fi

	# Link files
	link_files
}

link_files()
{
    if [[ "$DOTINSTALL" != "server" ]]
    then
        # Create nvim directory
        mkdir -p ~/.config/nvim
        mkdir -p ~/.config/nvim/after/plugin
    fi

    # Clean
    clean

    # Create backups
    backup

    echo "Linking files"
    # Link
    ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
    ln -s ~/.dotfiles/.zshrc ~/.zshrc
    ln -s ~/.dotfiles/.inputrc ~/.inputrc
    ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

    if [[ "$DOTINSTALL" != "server" ]]
    then
        ln -s ~/.dotfiles/.vimrc ~/.vimrc
        ln -s ~/.dotfiles/.vimrc ~/.config/nvim/init.vim
        ln -s ~/.dotfiles/plugin ~/.config/nvim/after/plugin
    else
        ln -s ~/.dotfiles/.vimrc-server ~/.vimrc
    fi

}

backup()
{

    echo "Backing up files"
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
    if [ -f ~/.inputrc ]; then 
        mv ~/.inputrc ~/.backups/.inputrc.backup 
    fi
    if [ -f ~/.tmux.conf ]; then 
        mv ~/.tmux.conf ~/.backups/.tmux.conf.backup 
    fi

    if [[ "$DOTINSTALL" != "server" ]]
    then
        if [ -f ~/.config/nvim/init.vim ]; then 
            mv ~/.config/nvim/init.vim ~./.backups/.nvim.backup
        fi
        if [ -f ~/.config/nvim/after/plugin ]; then 
            mv ~/.config/nvim/after/plugin ~./.backups/.nvim.plugin.backup
        fi
    fi
}

clean()
{
    echo "Removing linked files"
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
    if [ -L ~/.inputrc ]; then 
        rm ~/.inputrc
    fi
    if [ -L ~/.gitconfig ]; then 
        rm ~/.gitconfig
    fi

    if [[ "$DOTINSTALL" != "server" ]]
    then
        if [ -L ~/.config/nvim/init.vim ]; then 
            rm ~/.config/nvim/init.vim
        fi
        if [ -L ~/.config/nvim/after/plugin ]; then 
            rm -rf ~/.config/nvim/after/plugin
        fi
    fi
    
    # Restore Backups
    echo "Restoring old files"
    if [ -f ~/.backups/.vimrc.backup ]; then 
        mv ~/.backups/.vimrc.backup ~/.vimrc 
    fi
    if [ -f ~/.backups/.gitconfig.backup ]; then 
        mv ~/.backups/.gitconfig.backup ~/.gitconfig 
    fi
    if [ -f ~/.backups/.zshrc.backup ]; then 
        mv ~/.backups/.zshrc.backup ~/.zshrc  
    fi
    if [ -f ~/.backups/.inputrc.backup ]; then 
        mv ~/.backups/.inputrc.backup ~/.inputrc
    fi
    if [ -f ~/.backups/.tmux.conf.backup ]; then 
        mv ~/.backups/.tmux.conf.backup ~/.tmux.conf 
    fi
    if [[ "$DOTINSTALL" != "server" ]]
    then
        if [ -f ~/.config/nvim/init.vim ]; then 
            mv ~./.backups/.nvim.backup ~/.config/nvim/init.vim 
        fi
        if [ -f ~/.config/nvim/after/after/plugin ]; then 
            mv ~./.backups/.nvim.plugin.backup ~/.config/nvim/after/plugin
        fi
    fi
    }

    install_ohmyzsh() {
        # Zsh should be installed already
        if [ -d ~/.oh-my-zsh ]; then
            echo 'Oh my Zsh is already installed'
        else
            echo 'Installing Oh my Zsh'
            sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
            source ~/.zshrc
        fi

		if ! command -v git &> /dev/null
        then
            echo 'Git not installed try again after installing git'
        else
            if [[ -z "${ZSH_CUSTOM }" ]]; then
                echo 'oh my zsh environment variable not found, try again or run oh my zsh plugin installation'
            else
                echo 'Installing zsh suggestions and syntax highlighting'
                git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
                git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
            fi
        fi
    }

    install_ohmyzsh_plugin() {
        if [ -d ~/.oh-my-zsh ]; then
            echo 'Installing zsh suggestions and syntax highlighting'
            mkdir -p ~/.oh-my-zsh/custom
            git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
            git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
        else
            echo 'You need to install Oh My Zsh before running this !'
        fi

    }

echo 'Dotfiles installation'
echo '---------------------'
echo ''
echo '1. Setup Dotfiles'
echo '2. Link Dotfiles'
echo '3. Install Supporting deps'
echo '4. Clean Dotfiles'
echo '5. Setup Dotfiles for Server'
echo '6. Install Oh my Zsh'
echo '7. Install Oh my Zsh Plugins'
echo '8. Exit'
while true; do
    read -p 'Select option [1,7]: ' option
    case $option in
        1 ) setup; break;;
        2 ) link_files; break;;
        3 ) package_install; break;;
        4 ) clean; break;;
        5 ) DOTINSTALL='server';setup; break;;
        6 ) install_ohmyzsh; break;;
        7 ) install_ohmyzsh_plugin; break;;
        8 ) exit;;
        * ) echo "Please select a valid input !";;
    esac
done
