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
    #TODO: Create seperate bundles for brew categories and add options to choose between
    #TODO: Add ubuntu installation style category selection with default selection
    brew bundle
  elif [[ "$OSTYPE" == "linux-gnu"* ]]
  then
    echo 'Updating'
    sudo apt update -qq
    echo 'Installing'
    if [[ "$DOTENV" == "lite" ]]
    then
      sudo apt install $(cat AptServerList) -y -qq;
    else
      sudo apt install $(cat AptServerList AptDesktopList) -y -qq;
    fi
  fi
}

setup()
{

  if [[ "$OSTYPE" == "linux-gnu"* ]]
  then
    echo 'Dotfiles Environment'
    echo '---------------------'
    echo ''
    echo '1. Lite'
    echo '2. Desktop'

    while true; do
      read -p 'Select option [2]: ' option
      option=${option:-2}
      case $option in
        1 ) DOTENV=lite; break;;
        2 ) DOTENV=desktop; break;;
        * ) echo "Please select a valid input !";;
      esac
    done
  fi

  # Install Packages
  package_install

  echo 'Configure default SHELL'
  echo '---------------------'
  echo ''
  echo '1. Bash'
  echo '2. Zsh'
  echo '3. Fish'

  while true; do
    read -p 'Select option [2]: ' option
    option=${option:-2}
    case $option in
      1 ) install_ohmybash; break;;
      2 ) install_ohmyzsh; break;;
      3 ) install_ohmyfish; break;;
      * ) echo "Please select a valid input !";;
    esac
  done

  echo 'Configure Text Editor'
  echo '---------------------'
  echo ''
  echo '1. Vim (Depreciated)'
  echo '2. NeoVim'
  echo '3. LazyVim'

  while true; do
    read -p 'Select option [2]: ' option
    option=${option:-2}
    case $option in
      1 ) EDITOR=vim; break;;
      2 ) EDITOR=neovim; break;;
      3 ) EDITOR=lazyvim; break;;
      * ) echo "Please select a valid input !";;
    esac
  done

  # Tmux
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  # Vim
  if [[ "$EDITOR" == "vim" ]]
  then
    mkdir -p ~/.vim/undo
    mkdir -p ~/.vim/pack/themes/start
    cd ~/.vim/pack/themes/start
    git clone https://github.com/dracula/vim.git dracula

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
    mkdir ~/.vim/plugged

    # Language Support from Vim
    if [[ "$EDITOR" == "neovim" ]]
    then
      sudo apt install -y -qq nodejs npm
      npm install -g typescript typescript-language-server diagnostic-languageserver pyright prettier
    fi
  else

    # NeoVim
    mkdir -p ~/.config/nvim/undo
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    pip3 install --user pynvim
  fi


  # Link files
  link_files
}

link_files()
{
    # Clean
    clean

    # Create backups
    backup

    echo "Linking files"
    # Link
    # TODO: allow only if tmux is there
    ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
    ln -s ~/.dotfiles/.inputrc ~/.inputrc
    if [[ "$SHELL" == *"zsh" ]]
    then
      ln -s ~/.dotfiles/.zshrc ~/.zshrc
    elif [[ "$SHELL" == *"bash" ]]
    then
      ln -s ~/.dotfiles/.bashrc ~/.bashrc
    fi
    ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

    # TODO: allow only if vim is there
    ln -s ~/.dotfiles/.vimrc ~/.vimrc
    # TODO: allow only if neovim is there
    ln -s ~/.dotfiles/nvim ~/.config

  }

  # Helper Functions {{{
  backupFiles() {
    if [ -f ~/.$1 ]; then 
      mv ~/.$1 ~/.backups/.$1.backup
    fi
  }

  removeLinkedFiles() {
    if [ -L $1 ]; then 
      rm -r $1
    fi
  }

  restoreBackupFiles() {
    if [ -f ~/.backups/.$1.backup ]; then 
      mv ~/.backups/.$1.backup ~/.$1 
    fi
  }
  # }}}

  backup()
  {

    echo "Backing up files"
    mkdir -p ~/.backups
    cd ~/.backups

    backupFiles vimrc
    backupFiles tmux.conf
    if [[ "$SHELL" == *"zsh" ]]
    then
      backupFiles zshrc
    elif [[ "$SHELL" == *"bash" ]]
    then
      backupFiles bashrc
    fi
    backupFiles inputrc
    backupFiles gitconfig

    if [ -f ~/.config/nvim/init.vim ]; then 
      mv ~/.config/nvim ~./.backups/.nvim.backup
    fi
  }

  clean()
  {
    echo "Removing linked files"
    # Remove Links
    removeLinkedFiles ~/.vimrc
    removeLinkedFiles ~/.tmux.conf
    if [[ "$SHELL" == *"zsh" ]]
    then
      removeLinkedFiles ~/.zshrc
    elif [[ "$SHELL" == *"bash" ]]
    then
      removeLinkedFiles ~/.bashrc
    fi
    removeLinkedFiles ~/.inputrc
    removeLinkedFiles ~/.gitconfig
    removeLinkedFiles ~/.config/nvim

    # Restore Backups
    echo "Restoring old files"
    restoreBackupFiles vimrc
    restoreBackupFiles tmux.conf
    if [[ "$SHELL" == *"zsh" ]]
    then
      restoreBackupFiles zshrc
    elif [[ "$SHELL" == *"bash" ]]
    then
      restoreBackupFiles bashrc
    fi
    restoreBackupFiles inputrc
    restoreBackupFiles gitconfig

    if [ -f ~/.config/nvim/init.vim ]; then 
      mv ~./.backups/.nvim.backup ~/.config/nvim
    fi
  }

# Install Shell Tools {{{
install_ohmyzsh() {
  if [ "$OSTYPE" == "darwin"* ] && [ "$SHELL" != *"zsh" ]
  then
    brew install zsh
  elif [ "$OSTYPE" == "linux-gnu"* ] && ["$SHELL" != *"zsh"]
  then
    sudo apt install zsh
  fi

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
    if [[ -z "${ZSH_CUSTOM}" ]]; then
      echo 'Installing zsh suggestions and syntax highlighting without environment variable'
      mkdir -p ~/.oh-my-zsh/custom
      git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
      git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    else
      echo 'Installing zsh suggestions and syntax highlighting'
      git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
      git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    fi
  fi
}

install_ohmybash() {
  if [ "$OSTYPE" == "darwin"* ] && [ "$SHELL" != *"bash" ]
  then
    brew install bash
  elif [ "$OSTYPE" == "linux-gnu"* ] && ["$SHELL" != *"bash"]
  then
    sudo apt install bash
  fi

  if [ -d ~/.oh-my-bash ]; then
    echo 'Oh my Bash is already installed'
  else
    echo 'Installing Oh my Bash'
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
    source ~/.bashrc
  fi
}

install_ohmyfish() {
  if [ "$OSTYPE" == "darwin"* ] && [ "$SHELL" != *"fish" ]
  then
    brew install fish
  elif [ "$OSTYPE" == "linux-gnu"* ] && ["$SHELL" != *"fish"]
  then
    sudo apt install fish
  fi

  if [ -d ~/.oh-my-fish ]; then
    echo 'Oh my Fish is already installed'
  else
    echo 'Installing Oh my Fish'
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish 
  fi
}
#}}}

######################################################################################}}}
#   Dotfile Installation Setup
######################################################################################

echo 'Dotfiles installation'
echo '---------------------'
echo ''
echo '1. Setup Dotfiles'
echo '2. Link Dotfiles'
echo '3. Install Supporting deps'
echo '4. Clean Dotfiles'
echo '5. Exit'
while true; do
  read -p 'Select option [1,7]: ' option
  case $option in
    1 ) setup; break;;
    2 ) link_files; break;;
    3 ) package_install; break;;
    4 ) clean; break;;
    5 ) exit;;
    * ) echo "Please select a valid input !";;
  esac
done
