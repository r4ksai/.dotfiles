#!/usr/bin/env bash
# Base Linux profile.
# Always runs as part of install.sh on both server and desktop Linux.
# Installs: zsh + OMZ + p10k, neovim, tmux + TPM, python3 + pyenv + uv,
#           peco, ufw, fail2ban, SSH hardening, dotfile symlinks.
#
# Requires: gum and the step/ok/skip/warn helpers from install.sh.

BACKUP_DIR="$HOME/.dotfiles-backups"

echo ""
gum style --bold --foreground 212 "  Profile: base"
echo ""

# ── Symlink helper ────────────────────────────────────────────────────────────
# Same logic as setup-mac.sh so backups are consistent across platforms.
#   • Already correct symlink → skip
#   • Real file → back up to ~/.dotfiles-backups/, then link
#   • Stale/wrong symlink → remove, then link
_link() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"

  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    skip "$(basename "$dst")"
    return
  fi

  if [[ -e "$dst" && ! -L "$dst" ]]; then
    mkdir -p "$BACKUP_DIR"
    local rel="${dst#"$HOME/"}"
    local backup="$BACKUP_DIR/${rel//\//__}"
    mv "$dst" "$backup"
    warn "Backed up $(basename "$dst") → $backup"
  fi

  [[ -L "$dst" ]] && rm "$dst"
  ln -s "$src" "$dst"
  ok "$(basename "$dst")"
}

# ── Packages ──────────────────────────────────────────────────────────────────
step "Updating apt..."
sudo apt update -qq && sudo apt upgrade -y -qq

step "Installing base packages..."
sudo apt install -y \
  git curl wget zsh tmux \
  fzf ripgrep \
  gawk unzip tar \
  python3 python3-pip python3-venv \
  build-essential

# These packages have distro-version naming quirks — fail silently if unavailable
sudo apt install -y bat      2>/dev/null || true
sudo apt install -y lsd      2>/dev/null || true
sudo apt install -y fd-find  2>/dev/null || true
sudo apt install -y btop     2>/dev/null || true

# Ubuntu/Debian ship bat as "batcat" and fd as "fdfind" — normalise to expected names
[[ -f /usr/bin/batcat ]] && mkdir -p ~/.local/bin && ln -sf /usr/bin/batcat ~/.local/bin/bat
[[ -f /usr/bin/fdfind ]] && mkdir -p ~/.local/bin && ln -sf /usr/bin/fdfind ~/.local/bin/fd

ok "Base packages"

# peco — interactive filter; not in standard apt repos, install from GitHub release
if ! command -v peco &>/dev/null; then
  gum spin --spinner dot --title "Installing peco..." -- bash -c '
    curl -sLo /tmp/peco.tar.gz \
      "https://github.com/peco/peco/releases/download/v0.5.11/peco_linux_amd64.tar.gz"
    tar -C /tmp -xzf /tmp/peco.tar.gz
    sudo mv /tmp/peco_linux_amd64/peco /usr/local/bin/peco
    rm -rf /tmp/peco.tar.gz /tmp/peco_linux_amd64
  '
  ok "peco"
fi

# ── Neovim ────────────────────────────────────────────────────────────────────
# Install latest stable from GitHub — apt version is often several releases behind
if ! command -v nvim &>/dev/null; then
  gum spin --spinner dot --title "Installing Neovim (latest stable)..." -- bash -c '
    curl -sLo /tmp/nvim.tar.gz \
      "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
    tar -C /tmp -xzf /tmp/nvim.tar.gz
    sudo mv /tmp/nvim-linux-x86_64 /opt/nvim
    sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
    rm /tmp/nvim.tar.gz
  '
  ok "Neovim"
else
  skip "Neovim"
fi

# ── Python ────────────────────────────────────────────────────────────────────
# python3 (from apt above) is immediately available.
# pyenv allows managing multiple Python versions alongside the system one.
if [[ ! -d ~/.pyenv ]]; then
  step "Installing pyenv build dependencies..."
  sudo apt install -y \
    libssl-dev libffi-dev libbz2-dev libreadline-dev libsqlite3-dev \
    liblzma-dev zlib1g-dev libncursesw5-dev libgdbm-dev libnss3-dev \
    tk-dev uuid-dev

  gum spin --spinner dot --title "Installing pyenv..." -- \
    bash -c 'curl https://pyenv.run | bash'
  ok "pyenv — run: pyenv install 3.11 && pyenv global 3.11"
else
  skip "pyenv"
fi

# uv — fast Python package and project manager
if ! command -v uv &>/dev/null && [[ ! -f ~/.local/bin/uv ]]; then
  gum spin --spinner dot --title "Installing uv..." -- \
    bash -c 'curl -LsSf https://astral.sh/uv/install.sh | sh'
  ok "uv"
else
  skip "uv"
fi

# ── Oh My Zsh + Powerlevel10k ─────────────────────────────────────────────────
if [[ ! -d ~/.oh-my-zsh ]]; then
  gum spin --spinner dot --title "Installing Oh My Zsh..." -- bash -c '
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
      "" --unattended
  '
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]]; then
  gum spin --spinner dot --title "Installing Powerlevel10k..." -- \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
      "$ZSH_CUSTOM/themes/powerlevel10k"
fi

[[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]] && \
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions" &>/dev/null || true

[[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]] && \
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" &>/dev/null || true

ok "Oh My Zsh + Powerlevel10k + plugins"

# ── Tmux Plugin Manager ───────────────────────────────────────────────────────
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &>/dev/null
  ok "TPM (Tmux Plugin Manager)"
else
  skip "TPM"
fi

# ── Security ──────────────────────────────────────────────────────────────────
echo ""
gum style --bold --foreground 212 "  Security"
echo ""

sudo apt install -y ufw fail2ban

# ufw: deny all incoming traffic except SSH
if ! sudo ufw status | grep -q "Status: active"; then
  sudo ufw default deny incoming  &>/dev/null
  sudo ufw default allow outgoing &>/dev/null
  sudo ufw allow ssh              &>/dev/null
  sudo ufw --force enable         &>/dev/null
  ok "ufw — deny incoming, allow SSH"
else
  skip "ufw (already active)"
fi

# fail2ban: ban IPs that fail SSH auth 5 times within 10 minutes, for 1 hour
if [[ ! -f /etc/fail2ban/jail.d/sshd-local.conf ]]; then
  cat <<'EOF' | sudo tee /etc/fail2ban/jail.d/sshd-local.conf > /dev/null
[sshd]
enabled  = true
port     = ssh
maxretry = 5
bantime  = 3600
findtime = 600
EOF
  sudo systemctl enable fail2ban &>/dev/null
  sudo systemctl restart fail2ban
  ok "fail2ban — 5 attempts → 1h ban"
else
  skip "fail2ban"
fi

# SSH hardening: disables password auth and root login.
# Requires confirmation — getting locked out is unrecoverable without console access.
echo ""
warn "SSH hardening disables password auth and root login."
warn "Ensure your public key is already in ~/.ssh/authorized_keys."
echo ""
if gum confirm "  Apply SSH hardening?"; then
  cat <<'EOF' | sudo tee /etc/ssh/sshd_config.d/99-hardening.conf > /dev/null
PasswordAuthentication no
PermitRootLogin no
MaxAuthTries 3
X11Forwarding no
AllowAgentForwarding no
EOF
  sudo systemctl reload ssh 2>/dev/null || sudo systemctl reload sshd 2>/dev/null || true
  ok "SSH hardened — no passwords, no root login, max 3 tries"
else
  skip "SSH hardening"
fi

# ── Symlinks ──────────────────────────────────────────────────────────────────
echo ""
gum style --bold --foreground 212 "  Symlinks"
echo ""

mkdir -p ~/.config

_link "$DOTFILES/server/.zshrc"    ~/.zshrc
_link "$DOTFILES/server/.zprofile" ~/.zprofile
_link "$DOTFILES/.tmux.conf"       ~/.tmux.conf
_link "$DOTFILES/.inputrc"         ~/.inputrc
_link "$DOTFILES/.gitconfig"       ~/.gitconfig
_link "$DOTFILES/nvim"             ~/.config/nvim

# ── Default shell ─────────────────────────────────────────────────────────────
if [[ "$SHELL" != "$(command -v zsh)" ]]; then
  chsh -s "$(command -v zsh)"
  ok "Default shell → zsh (re-login to apply)"
fi

echo ""
ok "Base profile complete"
