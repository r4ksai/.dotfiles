#!/usr/bin/env bash
# Web Dev profile.
# Installs: nvm + Node, uv (Python package manager), Docker, PostgreSQL client.
# Python + pyenv are already installed by the base profile.
#
# Requires: gum and the step/ok/skip/warn helpers from install.sh.

echo ""
gum style --bold --foreground 212 "  Profile: webdev"
echo ""

# ── nvm + Node ────────────────────────────────────────────────────────────────
if [[ ! -d ~/.nvm ]]; then
  gum spin --spinner dot --title "Installing nvm..." -- \
    bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash'
  ok "nvm — run: nvm install --lts"
else
  skip "nvm"
fi

# ── Docker ────────────────────────────────────────────────────────────────────
# Uses Docker's official convenience script — not wrapped in gum spin since it
# may prompt for confirmation on some distros.
if ! command -v docker &>/dev/null; then
  step "Installing Docker..."
  curl -fsSL https://get.docker.com | sh
  sudo usermod -aG docker "$USER"
  ok "Docker — log out and back in for the docker group to apply"
else
  skip "Docker"
fi

# ── PostgreSQL client ─────────────────────────────────────────────────────────
if ! command -v psql &>/dev/null; then
  gum spin --spinner dot --title "Installing PostgreSQL client..." -- \
    sudo apt install -y postgresql-client
  ok "PostgreSQL client"
else
  skip "PostgreSQL client"
fi

echo ""
ok "Web Dev profile complete"
