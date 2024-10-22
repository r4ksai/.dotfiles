#!/bin/bash

package_install() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v brew &>/dev/null; then
      echo 'Installing Homebrew'
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    export PATH=/opt/homebrew/bin:$PATH
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
    echo 'Installing brew bundle'
    #TODO: Create separate bundles for brew categories and add options to choose between
    #TODO: Add ubuntu installation style category selection with default selection
    brew bundle
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo 'Updating'
    sudo apt update -qq && sudo apt upgrade -y
    echo 'Installing'
    sudo apt install $(cat AptServerList) -y -qq
  fi
}

setup() {

  # Install Packages
  package_install

  # Install zsh
  install_ohmyzsh

  # Tmux
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  # Link files
  link_files
}

link_files() {
  # Clean
  clean

  # Create backups
  backup

  echo "Linking files"
  # Link
  ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
  ln -s ~/.dotfiles/.inputrc ~/.inputrc
  ln -s ~/.dotfiles/.zshrc ~/.zshrc
  ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
  ln -s ~/.dotfiles/nvim ~/.config/nvim

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

backup() {

  echo "Backing up files"
  mkdir -p ~/.backups
  cd ~/.backups

  backupFiles vimrc
  backupFiles tmux.conf
  backupFiles zshrc
  backupFiles inputrc
  backupFiles gitconfig
  mv ~/.config/nvim ~/.backups/.nvim.backup
}

clean() {
  echo "Removing linked files"
  # Remove Links
  removeLinkedFiles ~/.vimrc
  removeLinkedFiles ~/.tmux.conf
  removeLinkedFiles ~/.zshrc
  removeLinkedFiles ~/.inputrc
  removeLinkedFiles ~/.gitconfig
  removeLinkedFiles ~/.config/nvim

  # Restore Backups
  echo "Restoring old files"
  restoreBackupFiles vimrc
  restoreBackupFiles tmux.conf
  restoreBackupFiles zshrc
  restoreBackupFiles inputrc
  restoreBackupFiles gitconfig

  mv ~./.backups/.nvim.backup ~/.config/nvim
}

# Install Shell Tools {{{
install_ohmyzsh() {
  if [ "$OSTYPE" == "darwin"* ]; then
    brew install zsh
  elif [ "$OSTYPE" == "linux-gnu"* ]; then
    sudo apt install zsh
  fi

  if [ -d ~/.oh-my-zsh ]; then
    echo 'Oh my Zsh is already installed'
  else
    echo 'Installing Oh my Zsh'
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    source ~/.zshrc
  fi

  if ! command -v git &>/dev/null; then
    echo 'Git not installed try again after installing git'
  else
    echo 'Installing zsh suggestions and syntax highlighting without environment variable'
    mkdir -p ~/.oh-my-zsh/custom
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
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
  read -p 'Select option [1,5]: ' option
  case $option in
  1)
    setup
    break
    ;;
  2)
    link_files
    break
    ;;
  3)
    package_install
    break
    ;;
  4)
    clean
    break
    ;;
  5) exit ;;
  *) echo "Please select a valid input !" ;;
  esac
done
