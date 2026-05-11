#!/usr/bin/env bash
# Embedded profile.
# Installs: AVR toolchain, Arduino CLI, PlatformIO, cmake/make/ninja, minicom.
#
# Requires: gum and the step/ok/skip/warn helpers from install.sh.

echo ""
gum style --bold --foreground 212 "  Profile: embedded"
echo ""

# ── Build tools + AVR toolchain ───────────────────────────────────────────────
gum spin --spinner dot --title "Installing build tools and AVR toolchain..." -- \
  sudo apt install -y \
    build-essential cmake make ninja-build \
    gcc-avr avr-libc avrdude \
    dfu-util libusb-dev minicom \
    python3-serial
ok "Build tools + AVR toolchain"

# ── Arduino CLI ───────────────────────────────────────────────────────────────
if ! command -v arduino-cli &>/dev/null; then
  gum spin --spinner dot --title "Installing Arduino CLI..." -- bash -c '
    curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh \
      | sh -s -- --dest /tmp/arduino-cli-install
    sudo mv /tmp/arduino-cli-install/arduino-cli /usr/local/bin/arduino-cli
    rm -rf /tmp/arduino-cli-install
  '
  ok "Arduino CLI"
else
  skip "Arduino CLI"
fi

# ── PlatformIO ────────────────────────────────────────────────────────────────
# Installs into ~/.platformio and symlinks pio/platformio into ~/.local/bin
if [[ ! -f ~/.platformio/penv/bin/pio ]]; then
  gum spin --spinner dot --title "Installing PlatformIO..." -- bash -c '
    curl -fsSL \
      https://raw.githubusercontent.com/platformio/platformio-core-installer/master/get-platformio.py \
      -o /tmp/get-platformio.py
    python3 /tmp/get-platformio.py
    mkdir -p ~/.local/bin
    ln -sf ~/.platformio/penv/bin/pio        ~/.local/bin/pio
    ln -sf ~/.platformio/penv/bin/platformio ~/.local/bin/platformio
    rm /tmp/get-platformio.py
  '
  ok "PlatformIO"
else
  skip "PlatformIO"
fi

echo ""
ok "Embedded profile complete"
