#!/usr/bin/env zsh

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

PASS=0
FAIL=0

ok()      { echo "  ${GREEN}✔${RESET}  $1"; ((PASS++)) || true; }
fail()    { echo "  ${RED}✘${RESET}  $1"; ((FAIL++)) || true; }
warn()    { echo "  ${YELLOW}~${RESET}  $1"; }
section() { echo "\n${BOLD}${BLUE}▶ $1${RESET}"; }

check_cmd()  { command -v "$1" &>/dev/null && ok "$1 installed" || fail "$1 not installed"; }
check_dir()  { [[ -d "$1" ]] && ok "$2" || fail "$2 — $1 missing"; }
check_link() {
  local target="$1" label="$2"
  if [[ -L "$target" ]]; then
    ok "$label → $(readlink "$target")"
  elif [[ -e "$target" ]]; then
    warn "$label exists but is not a symlink"
  else
    fail "$label not linked ($target missing)"
  fi
}
check_brew() { brew list "$1" &>/dev/null 2>&1 && ok "brew: $1" || fail "brew: $1"; }
check_cask() { brew list --cask "$1" &>/dev/null 2>&1 && ok "cask: $1" || fail "cask: $1"; }
check_mas()  {
  local name="$1" id="$2"
  mas list 2>/dev/null | grep -q "^$id" && ok "mas: $name" || fail "mas: $name ($id)"
}

# ────────────────────────────────────────────────
section "Core Package Managers"
# ────────────────────────────────────────────────

check_cmd brew

if [[ -e /nix/var/nix/profiles/default/bin/nix ]]; then
  ok "Nix installed"
else
  fail "Nix not installed"
fi

if command -v darwin-rebuild &>/dev/null; then
  ok "nix-darwin installed"
else
  fail "nix-darwin not installed"
fi

# ────────────────────────────────────────────────
section "Shells & Prompts"
# ────────────────────────────────────────────────

check_dir ~/.oh-my-zsh "Oh My Zsh"
check_dir ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions "zsh-autosuggestions plugin"
check_dir ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting "zsh-syntax-highlighting plugin"
[[ -f ~/.dracula-syntax-highlighting.sh ]] && ok "Dracula syntax highlighting file" || fail "Dracula syntax highlighting file missing"

# ────────────────────────────────────────────────
section "Dotfile Symlinks"
# ────────────────────────────────────────────────

check_link ~/.zshrc          ".zshrc"
check_link ~/.zprofile       ".zprofile"
check_link ~/.p10k.zsh       ".p10k.zsh"
check_link ~/.inputrc        ".inputrc"
check_link ~/.gitconfig      ".gitconfig"
check_link ~/.tmux.conf      ".tmux.conf"
check_link ~/.dracula-syntax-highlighting.sh ".dracula-syntax-highlighting.sh"
check_link ~/.config/nvim    "~/.config/nvim"
check_link ~/.config/yazi    "~/.config/yazi"
check_link ~/.config/nix-darwin "~/.config/nix-darwin"

# ────────────────────────────────────────────────
section "Tmux"
# ────────────────────────────────────────────────

check_cmd tmux
check_dir ~/.tmux/plugins/tpm "TPM (Tmux Plugin Manager)"

# ────────────────────────────────────────────────
section "Nix System Packages"
# ────────────────────────────────────────────────

# Development
for cmd in lazydocker lazygit lazysql commitizen tig pyenv; do
  check_cmd "$cmd"
done

# Testing
check_cmd k6

# Stats
for cmd in neofetch btop htop; do
  check_cmd "$cmd"
done

# Essentials
for cmd in git tmux; do
  check_cmd "$cmd"
done

# Terminal
for cmd in fish lsd bat fzf peco fd rg ttyper; do
  check_cmd "$cmd"
done

# Networking
for cmd in wget nmap yt-dlp; do
  check_cmd "$cmd"
done

# Utils
for cmd in ffmpeg gpg fdupes ttyd jrnl; do
  check_cmd "$cmd"
done

# Docs (package: tlrc, command: tldr)
check_cmd tldr

# ────────────────────────────────────────────────
section "Development Languages"
# ────────────────────────────────────────────────

if pyenv versions 2>/dev/null | grep -q "3\.11"; then
  ok "Python 3.11 installed via pyenv"
else
  fail "Python 3.11 not found via pyenv"
fi

if [[ -d "$HOME/.nvm" ]] || command -v nvm &>/dev/null 2>&1; then
  ok "nvm installed"
else
  fail "nvm not installed"
fi

check_cmd go
check_cmd node
check_cmd pnpm
check_cmd uv

# ────────────────────────────────────────────────
section "Homebrew Brews (from flake)"
# ────────────────────────────────────────────────

if command -v brew &>/dev/null; then
  for pkg in \
    iperf3 mole watch mosquitto \
    openssh libfido2 \
    go nvm pnpm mas neovim tailscale ansible imagemagick \
    readline xz httpie yazi uv wireguard-tools \
    cmake make avr-gcc avrdude minicom minipro platformio arduino-cli bear \
    mpv; do
    check_brew "$pkg"
  done
else
  warn "Homebrew not installed — skipping brew checks"
fi

# ────────────────────────────────────────────────
section "Homebrew Casks (from flake)"
# ────────────────────────────────────────────────

if command -v brew &>/dev/null; then
  for cask in \
    anydesk balenaetcher mqttx telegram \
    codex claude-code \
    boop ngrok wireshark-app httpie-desktop postman pgadmin4 kicad db-browser-for-sqlite \
    notion \
    libreoffice opal-app \
    obs blender audacity \
    creality-slicer bambu-studio \
    "logi-options+" numi shottr the-unarchiver flux-app appcleaner \
    nordvpn paragon-ntfs tailscale-app karabiner-elements \
    whatsapp bitwarden ticktick yubico-authenticator \
    firefox google-chrome \
    wezterm raycast \
    vlc discord; do
    check_cask "$cask"
  done
else
  warn "Homebrew not installed — skipping cask checks"
fi

# ────────────────────────────────────────────────
section "Mac App Store Apps (from flake)"
# ────────────────────────────────────────────────

if command -v mas &>/dev/null; then
  check_mas "Pandan"                   1569600264
  check_mas "Magnet"                   441258766
  check_mas "Steam Link"               1246969117
  check_mas "Amphetamine"              937984704
  check_mas "Keynote"                  409183694
  check_mas "Microsoft Remote Desktop" 1295203466
else
  warn "mas not installed — skipping App Store checks (brew install mas)"
fi

# ────────────────────────────────────────────────
section "SSH"
# ────────────────────────────────────────────────

setopt NULL_GLOB 2>/dev/null
keys=(~/.ssh/id_*.pub)
unsetopt NULL_GLOB 2>/dev/null
if [[ ${#keys[@]} -gt 0 && -f "${keys[1]}" ]]; then
  ok "SSH public key(s) found: $(for k in "${keys[@]}"; do basename "$k"; done | tr '\n' ' ')"
else
  fail "No SSH public key found in ~/.ssh/"
fi

if [[ -f ~/.ssh/config ]]; then
  ok "~/.ssh/config exists"
else
  warn "~/.ssh/config not found"
fi

# ────────────────────────────────────────────────
echo ""
echo "${BOLD}──────────────────────────────────────${RESET}"
echo "${BOLD}  Summary: ${GREEN}${PASS} done${RESET}, ${RED}${FAIL} pending${RESET}"
echo "${BOLD}──────────────────────────────────────${RESET}"
