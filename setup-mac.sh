#!/usr/bin/env bash
# Mac post-nix-darwin setup.
# Installs Oh My Zsh, Powerlevel10k, TPM, and creates all dotfile symlinks.
#
# Called automatically by install.sh (step 7), but safe to run standalone
# at any time — all steps are idempotent.
#
# Backups: any real file that would be replaced by a symlink is moved to
#   ~/.dotfiles-backups/<flattened-path>   e.g. .config__nvim
# To restore: run _restore <destination> or move files back manually.

set -euo pipefail

DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BACKUP_DIR="$HOME/.dotfiles-backups"

ok()   { echo "  ✓ $*"; }
skip() { echo "  – $*"; }
info() { echo "  → $*"; }
warn() { echo "  ! $*"; }

# ── Symlink helpers ───────────────────────────────────────────────────────────

# _link <dotfiles-source> <destination>
#   • Already pointing to the right source → skip (idempotent)
#   • Real file exists → back up to $BACKUP_DIR, then link
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
    local rel="${dst#"$HOME/"}"                   # strip $HOME/ prefix
    local backup="$BACKUP_DIR/${rel//\//__}"      # flatten: .config/nvim → .config__nvim
    mv "$dst" "$backup"
    warn "Backed up $(basename "$dst") → $backup"
  fi

  [[ -L "$dst" ]] && rm "$dst"
  ln -s "$src" "$dst"
  ok "$(basename "$dst")"
}

# _restore <destination>
#   Removes the symlink at <destination> and moves the backup back, if one exists.
#   Example: _restore ~/.zshrc
_restore() {
  local dst="$1"
  local rel="${dst#"$HOME/"}"
  local backup="$BACKUP_DIR/${rel//\//__}"

  [[ -L "$dst" ]] && rm "$dst"

  if [[ -e "$backup" ]]; then
    mv "$backup" "$dst"
    ok "Restored $(basename "$dst")"
  else
    warn "No backup found for $(basename "$dst")"
  fi
}

# ── Oh My Zsh ─────────────────────────────────────────────────────────────────
if [[ -d ~/.oh-my-zsh ]]; then
  skip "Oh My Zsh"
else
  info "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    "" --unattended
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]]; then
  info "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# Dracula syntax highlighting — sourced directly by .zshrc (not an OMZ plugin)
if [[ ! -f ~/.dracula-syntax-highlighting.sh ]]; then
  info "Installing Dracula syntax highlighting..."
  git clone --depth=1 https://github.com/dracula/zsh-syntax-highlighting.git /tmp/dracula-zsh
  mv /tmp/dracula-zsh/zsh-syntax-highlighting.zsh ~/.dracula-syntax-highlighting.sh
  rm -rf /tmp/dracula-zsh
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
  info "Installing TPM..."
  git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &>/dev/null
  ok "TPM"
else
  skip "TPM"
fi

# ── Symlinks ──────────────────────────────────────────────────────────────────
echo ""
info "Symlinking dotfiles..."
echo ""

# Shell
_link "$DOTFILES/.zshrc"                   ~/.zshrc
_link "$DOTFILES/.zprofile"                ~/.zprofile
_link "$DOTFILES/.p10k.zsh"                ~/.p10k.zsh

# Tools
_link "$DOTFILES/.gitconfig"               ~/.gitconfig
_link "$DOTFILES/.tmux.conf"               ~/.tmux.conf
_link "$DOTFILES/.inputrc"                 ~/.inputrc
_link "$DOTFILES/.wezterm.lua"             ~/.wezterm.lua

# App configs
_link "$DOTFILES/nvim"                     ~/.config/nvim
_link "$DOTFILES/yazi"                     ~/.config/yazi
_link "$DOTFILES/nix-darwin"               ~/.config/nix-darwin
_link "$DOTFILES/fish"                     ~/.config/fish
_link "$DOTFILES/alacritty"                ~/.config/alacritty
_link "$DOTFILES/lazygit"                  ~/.config/lazygit
_link "$DOTFILES/karabiner/karabiner.json" ~/.config/karabiner/karabiner.json
_link "$DOTFILES/git/ignore"               ~/.config/git/ignore
_link "$DOTFILES/gh/config.yml"            ~/.config/gh/config.yml
_link "$DOTFILES/ssh/config"               ~/.ssh/config

# Claude Code
_link "$DOTFILES/claude/CLAUDE.md"         ~/.claude/CLAUDE.md
_link "$DOTFILES/claude/agents"            ~/.claude/agents

echo ""
ok "Done — run: exec zsh"
