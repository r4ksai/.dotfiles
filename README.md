# Dotfiles

Cross-platform dotfiles for macOS (Apple Silicon) and Debian/Ubuntu Linux.
Installation is profile-based — pick what you need.

---

## Supported Platforms

| Platform | Tested On | Managed By |
|---|---|---|
| macOS (Apple Silicon) | macOS 14+ | nix-darwin + Homebrew |
| Debian / Ubuntu | Ubuntu 22.04+, Debian 12+ | apt + `install.sh` |

---

## Profiles

| Profile | Mac | Linux | What it installs |
|---|---|---|---|
| **base** | always (nix-darwin) | always | ZSH + p10k, Neovim, tmux, Python, ufw, fail2ban, SSH hardening |
| **webdev** | in flake | optional (auto on desktop) | Node (nvm), uv, Docker, PostgreSQL |
| **embedded** | in flake | optional (auto on desktop) | AVR toolchain, Arduino CLI, PlatformIO, cmake |

On Mac everything is managed declaratively by `nix-darwin/flake.nix`.
On Linux, `install.sh` auto-detects a desktop environment and pre-selects webdev + embedded if one is found — server installs default to base only.

---

## What Gets Installed

### Base (always)
- **Shell** — ZSH + Oh My Zsh + Powerlevel10k, vi-mode, autosuggestions, syntax highlighting
- **Editor** — Neovim full config (same on Mac and Linux)
- **Multiplexer** — tmux + TPM (Tmux Plugin Manager)
- **Terminal** — WezTerm (Mac only, via Homebrew cask)
- **CLI tools** — fzf, ripgrep, fd, bat, lsd/eza, btop, peco, lazygit, wget
- **Python** — python3 (apt) + pyenv (version manager) + uv (package manager)
- **Security** (Linux) — ufw, fail2ban (5 attempts → 1h ban), SSH hardening (no passwords, no root)

### Web Dev
- nvm + Node.js (version set manually after install: `nvm install --lts`)
- Docker + docker-compose
- PostgreSQL client

### Embedded
- AVR toolchain — avr-gcc, avrdude
- Arduino CLI
- PlatformIO
- Build tools — cmake, make, ninja
- Flashing/debug — dfu-util, libusb-dev, minicom

---

## Installation

### macOS

> Assumes a fresh Mac with internet access.

#### 1. Xcode Command Line Tools
```bash
xcode-select --install
```

#### 2. Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

#### 3. Nix — use the Determinate installer
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```
Re-open your terminal after this step.

#### 4. Clone dotfiles
```bash
git clone https://github.com/r4ksai/.dotfiles.git ~/.dotfiles
```

#### 5. Apply nix-darwin config
This installs all packages (nix + Homebrew), applies macOS system defaults (dock,
finder, key repeat, Touch ID sudo, dock layout), and installs Mac App Store apps.
First run takes a while.
```bash
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.dotfiles/nix-darwin#air
```

#### 6. Symlinks + Oh My Zsh + TPM
```bash
bash ~/.dotfiles/setup-mac.sh
```

#### 7. Reload shell
```bash
exec zsh
```

---

### Linux — Debian / Ubuntu

```bash
git clone https://github.com/r4ksai/.dotfiles.git ~/.dotfiles
bash ~/.dotfiles/install.sh
```

The script detects your OS, shows a profile menu, and runs only what you select.
Core is always installed. All steps are idempotent — safe to re-run.

---

## Post-Install Steps

These apply on both platforms after the main install.

### Tmux plugins
Open a tmux session, then press `prefix + I` (capital I).

### Neovim plugins
Open `nvim` — lazy.nvim auto-installs all plugins on first launch.

### Powerlevel10k prompt
```bash
p10k configure
```

### Node.js version _(webdev profile)_
```bash
nvm install --lts
nvm use --lts
```

### Python version
```bash
pyenv install 3.11
pyenv global 3.11
```

### SSH Keys
```bash
# Generate a new key
ssh-keygen -t ed25519 -C "your@email.com"

# Add to agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Push public key to a server
ssh-copy-id user@host
```

### Agent SSH key
Use this key to grant agents server access without requiring repeated
hardware-key touch prompts during automated work.

```bash
# Grant agent-key access to one or more servers
agent-key.sh add user@host

# Check whether agent-key is present
agent-key.sh status user@host

# Remove agent-key access
agent-key.sh remove user@host
```

Claude/Codex agents should use `~/.ssh/keys/agent-key` for remote server SSH
unless told otherwise.

---

## Updating

### macOS
```bash
darwin-rebuild switch --flake ~/.dotfiles/nix-darwin#air
```

### Linux
```bash
bash ~/.dotfiles/install.sh   # re-run, idempotent
```

---

## Repository Structure

```
.dotfiles/
├── install.sh              # Unified entry — Mac (progress steps) + Linux (profile menu)
├── setup-mac.sh            # Mac: OMZ, TPM, symlinks (called by install.sh)
├── lib/
│   └── gum.sh              # Installs gum on Linux via Charm apt repo
│
├── profiles/               # Linux install profiles (sourced by install.sh)
│   ├── base.sh             # ZSH, Neovim, tmux, Python, security, symlinks
│   ├── webdev.sh           # Node (nvm), uv, Docker, PostgreSQL
│   └── embedded.sh         # AVR, Arduino CLI, PlatformIO, cmake
│
├── nix-darwin/
│   └── flake.nix           # macOS declarative config — packages + system defaults
│
├── nvim/                   # Neovim config (Mac and Linux — same config)
│
├── server/                 # Linux-specific shell config
│   ├── .zshrc              # ZSH config for servers
│   └── .zprofile           # Login shell — pyenv, nvm, uv, PATH
│
├── .zshrc                  # ZSH config (Mac)
├── .zprofile               # Login shell config (Mac)
├── .gitconfig              # Git config (shared)
├── .tmux.conf              # Tmux config (shared)
└── .p10k.zsh               # Powerlevel10k config
```
