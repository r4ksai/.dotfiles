#!/bin/bash
set -e

DOTFILES="$HOME/.dotfiles"

# ── Dependencies ──────────────────────────────────────────────────────────────
sudo apt update -qq && sudo apt upgrade -y
sudo apt install -y git tmux curl zsh fzf ripgrep fd-find python3-pip

# Better ls/cat if available in apt
sudo apt install -y lsd bat 2>/dev/null || true
# Ubuntu/Debian name bat as batcat and fd as fdfind — make proper symlinks
[ -f /usr/bin/batcat ] && mkdir -p ~/.local/bin && ln -sf /usr/bin/batcat ~/.local/bin/bat
[ -f /usr/bin/fdfind ] && mkdir -p ~/.local/bin && ln -sf /usr/bin/fdfind ~/.local/bin/fd

# Neovim (get latest stable, apt version is often stale)
if ! command -v nvim &>/dev/null; then
  curl -Lo /tmp/nvim.tar.gz \
    "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
  tar -C /tmp -xzf /tmp/nvim.tar.gz
  sudo mv /tmp/nvim-linux-x86_64 /opt/nvim
  sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
fi

# ── Clone dotfiles ────────────────────────────────────────────────────────────
if [ ! -d "$DOTFILES" ]; then
  git clone https://github.com/r4ksai/dotfiles "$DOTFILES"
fi

# ── Tmux plugin manager ───────────────────────────────────────────────────────
[ ! -d ~/.tmux/plugins/tpm ] && \
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# ── Oh My Zsh ────────────────────────────────────────────────────────────────
if [ ! -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    "" --unattended
fi

# Plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && \
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && \
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# ── Symlinks ──────────────────────────────────────────────────────────────────
backup_and_link() {
  local src="$1" dst="$2"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "${dst}.backup"
    echo "Backed up $dst"
  fi
  ln -sf "$src" "$dst"
  echo "Linked $dst"
}

mkdir -p ~/.config

backup_and_link "$DOTFILES/server/.zshrc"   ~/.zshrc
backup_and_link "$DOTFILES/server/.zprofile" ~/.zprofile
backup_and_link "$DOTFILES/.tmux.conf"       ~/.tmux.conf
backup_and_link "$DOTFILES/.inputrc"         ~/.inputrc
backup_and_link "$DOTFILES/.gitconfig"       ~/.gitconfig
backup_and_link "$DOTFILES/nvim-server"      ~/.config/nvim

# ── Set default shell to zsh ──────────────────────────────────────────────────
if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s "$(which zsh)"
  echo "Shell changed to zsh — re-login to apply"
fi

echo ""
echo "Done! Start a new shell or run: exec zsh"
echo "Then install tmux plugins with: tmux + prefix + I"
