# Home Brew
if ! command -v brew &>/dev/null; then
  echo 'Installing Homebrew'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# TODO: Install Nix Here

# OMZ
if [ -d ~/.oh-my-zsh ]; then
  echo 'Oh my Zsh is already installed'
else
  echo 'Installing Oh my Zsh'
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
  source ~/.zshrc
fi

git clone https://github.com/dracula/zsh-syntax-highlighting.git /tmp/zsh-syntax-highlighting
mv /tmp/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ~/.dracula-syntax-highlighting.sh

if ! command -v git &>/dev/null; then
  echo 'Git not installed try again after installing git'
else
  echo 'Installing zsh suggestions and syntax highlighting without environment variable'
  mkdir -p ~/.oh-my-zsh/custom
  git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

# Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# FIXME: Make Nix do this
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/.zprofile ~/.zprofile
ln -s ~/.dotfiles/.p10k.zsh ~/.p10k.zsh
ln -s ~/.dotfiles/.inputrc ~/.inputrc
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/nvim ~/.config/nvim
ln -s ~/.dotfiles/yazi ~/.config/yazi
ln -s ~/.dotfiles/nix-darwin/ ~/.config/nix-darwin
ln -s ~/.dotfiles/.dracula-syntax-highlighting.sh ~/.dracula-syntax-highlighting.sh
