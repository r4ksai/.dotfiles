sudo apt update && sudo apt upgrade -y
sudo apt install git tmux curl lsd fzf ripgrep bat fd neovim -y
sudo apt install zsh -y

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

mkdir -p ~/.config/nvim

mkdir ~/.backups
mv ~/.zshrc ~/.backups/.zshrc
mv ~/.inputrc ~/.backups/.inputrc
mv ~/.gitconfig ~/.backups/.gitconfig
mv ~/.tmux.conf ~/.backups/.tmux.conf
mv ~/.p10k.zsh ~/.backups/.p10k.zsh
mv ~/.zprofile ~/.backups/.zprofile
mv ~/.config/nvim ~/.backups/nvim

ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.inputrc ~/.inputrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/.p10k.zsh ~/.p10k.zsh
ln -s ~/.dotfiles/.zprofile ~/.zprofile
ln -s ~/.dotfiles/nvim ~/.config/nvim

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

git clone https://github.com/dracula/zsh-syntax-highlighting.git /tmp/zsh-syntax-highlighting
mv /tmp/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ~/.dracula-syntax-highlighting.sh

git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
