#!/usr/bin/env bash
# Unified dotfiles installer.
#
# macOS  — walks through a fixed sequence of steps (Xcode → Homebrew → Nix →
#           nix-darwin → setup-mac.sh). Each step is idempotent; already-done
#           steps are skipped automatically.
#
# Linux  — installs gum, shows a profile menu, then runs:
#           base (always) + any selected optional profiles.
#
# Usage: bash install.sh

set -euo pipefail

DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# ── Helpers (plain output — used before gum is available) ────────────────────
step()  { echo "  → $*"; }
ok()    { echo "  ✓ $*"; }
skip()  { echo "  – $*"; }
warn()  { echo "  ! $*"; }
die()   { echo "  ✗ $*" >&2; exit 1; }

# ── macOS ─────────────────────────────────────────────────────────────────────
mac_install() {
  echo ""
  echo "  macOS Setup"
  echo "  ════════════════════════════════════"
  echo ""

  # 1 — Xcode Command Line Tools
  if xcode-select -p &>/dev/null 2>&1; then
    skip "Xcode Command Line Tools"
  else
    step "Xcode Command Line Tools — a dialog will open, install from there"
    xcode-select --install
    read -rp "  Press Enter once the Xcode installation finishes: " _
    ok "Xcode Command Line Tools"
  fi

  # 2 — Homebrew
  if command -v brew &>/dev/null; then
    skip "Homebrew"
  else
    step "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ok "Homebrew"
  fi

  # 3 — gum (brew is available now; also in nix packages so subsequent runs use nix's copy)
  if ! command -v gum &>/dev/null; then
    step "Installing gum..."
    brew install gum
    ok "gum"
  fi

  echo ""
  gum style --border double --padding "1 4" --margin "1 0" --border-foreground 212 \
    "$(gum style --bold --foreground 212 'macOS Setup')"
  echo ""

  # 4 — Nix (Determinate installer — manages the Nix daemon independently of nix-darwin)
  if command -v nix &>/dev/null; then
    skip "Nix"
  else
    step "Installing Nix (Determinate)..."
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix \
      | sh -s -- install --no-confirm
    ok "Nix installed"
    echo ""
    gum style --foreground 214 "  Re-open your terminal, then re-run this script to continue."
    exit 0
  fi

  # 5 — Dotfiles
  if [[ -d "$HOME/.dotfiles" ]]; then
    skip "Dotfiles"
  else
    gum spin --spinner dot --title "Cloning dotfiles..." -- \
      git clone https://github.com/r4ksai/.dotfiles.git "$HOME/.dotfiles"
    ok "Dotfiles"
  fi

  # 6 — nix-darwin
  # Installs all nix + Homebrew packages, applies macOS system defaults,
  # and manages Mac App Store apps. First run takes several minutes.
  step "Applying nix-darwin config — first run takes a while..."
  sudo darwin-rebuild switch --flake "$DOTFILES/nix-darwin#air"
  ok "nix-darwin"

  # 7 — Symlinks, Oh My Zsh, TPM
  step "Setting up symlinks, Oh My Zsh, and TPM..."
  bash "$DOTFILES/setup-mac.sh"
  ok "Symlinks + Oh My Zsh + TPM"

  echo ""
  gum style --foreground 212 --bold "  Done!"
  echo ""
  echo "  Next steps:"
  echo "    exec zsh              — reload shell"
  echo "    p10k configure        — set up prompt style"
  echo "    tmux → prefix + I     — install tmux plugins"
  echo "    nvim                  — plugins auto-install on first launch"
  echo ""
}

# ── Linux ─────────────────────────────────────────────────────────────────────
linux_install() {
  [[ -f /etc/debian_version ]] || die "Only Debian/Ubuntu Linux is supported."

  # gum must be installed before any interactive UI is shown
  source "$DOTFILES/lib/gum.sh"
  install_gum_linux

  echo ""
  gum style --border double --padding "1 4" --margin "1 0" --border-foreground 212 \
    "$(gum style --bold --foreground 212 'Linux Dotfiles Installer')"
  echo ""

  # Detect whether a desktop environment is present.
  # If yes, pre-select all optional profiles; if not (server), leave them blank.
  has_desktop() {
    [[ -n "${XDG_CURRENT_DESKTOP:-}${DESKTOP_SESSION:-}" ]] && return 0
    dpkg -l ubuntu-desktop gnome-shell plasma-desktop xfce4 2>/dev/null \
      | grep -q "^ii" && return 0
    return 1
  }

  gum style --faint \
    "  base (always): zsh · neovim · tmux · python · ufw · fail2ban · SSH hardening"
  echo ""

  if has_desktop; then
    gum style --faint "  Desktop environment detected — all profiles pre-selected"
    PRESELECT="webdev,embedded"
  else
    gum style --faint "  Server environment detected — select extras if needed"
    PRESELECT=""
  fi
  echo ""

  echo "  Optional profiles:"
  echo "    webdev   — Node (nvm), uv, Docker, PostgreSQL"
  echo "    embedded — AVR toolchain, Arduino CLI, PlatformIO, cmake"
  echo ""

  GUM_ARGS=(--no-limit --header "Space to toggle · Enter to confirm:")
  [[ -n "$PRESELECT" ]] && GUM_ARGS+=(--selected="$PRESELECT")
  GUM_ARGS+=("webdev" "embedded")

  PROFILES=$(gum choose "${GUM_ARGS[@]}") || PROFILES=""
  echo ""

  # Base is always installed
  # shellcheck source=profiles/base.sh
  source "$DOTFILES/profiles/base.sh"

  [[ "$PROFILES" == *webdev*   ]] && source "$DOTFILES/profiles/webdev.sh"
  [[ "$PROFILES" == *embedded* ]] && source "$DOTFILES/profiles/embedded.sh"

  echo ""
  gum style --foreground 212 --bold "  Done!"
  echo ""
  echo "  Next steps:"
  echo "    exec zsh              — reload shell"
  echo "    p10k configure        — set up prompt style"
  echo "    tmux → prefix + I     — install tmux plugins"
  echo "    nvim                  — plugins auto-install on first launch"
  if [[ "$PROFILES" == *webdev* ]]; then
    echo "    nvm install --lts     — install Node LTS"
    echo "    pyenv install 3.11 && pyenv global 3.11"
  fi
  echo ""
}

# ── Entry point ───────────────────────────────────────────────────────────────
if [[ "$OSTYPE" == "darwin"* ]]; then
  mac_install
else
  linux_install
fi
