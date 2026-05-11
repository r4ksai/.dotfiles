#!/usr/bin/env bash
# Bootstrap gum on Debian/Ubuntu via the Charm apt repo.
# On macOS, gum is installed by install.sh after Homebrew is ready,
# and is also declared in nix-darwin/flake.nix as a permanent package.
#
# Usage: source this file, then call install_gum_linux.

install_gum_linux() {
  command -v gum &>/dev/null && return 0

  echo "  → Installing gum..."
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://repo.charm.sh/apt/gpg.key \
    | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
  echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" \
    | sudo tee /etc/apt/sources.list.d/charm.list > /dev/null
  sudo apt update -qq && sudo apt install -y gum
  echo "  ✓ gum"
}
