{
  description = "Sai's nix-darwin system flake";

  inputs = {
    nixpkgs.url     = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    nix-darwin.url  = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
    let
      configuration = { pkgs, ... }: {
        nixpkgs.config.allowUnfree = true;
        nixpkgs.hostPlatform = "aarch64-darwin";

        # ── System Packages ───────────────────────────────────────────────────
        environment.systemPackages = with pkgs; [
          # Essentials
          git
          gh                          # GitHub CLI
          tmux                        # Terminal multiplexer
          reattach-to-user-namespace

          # Development
          lazydocker
          lazygit
          lazysql
          commitizen                  # Conventional commit helper
          tig                         # Terminal git browser
          pyenv                       # Python version manager

          # Shell & Terminal
          fish
          lsd                         # ls replacement
          bat                         # cat replacement
          fzf                         # Fuzzy finder
          peco                        # Interactive filter
          fd                          # find replacement
          ripgrep                     # grep replacement
          ttyper                      # Typing practice CLI

          # Monitoring
          neofetch
          btop
          htop

          # Networking
          wget
          nmap
          yt-dlp

          # Utils
          ffmpeg
          gnupg
          fdupes
          ttyd                        # Terminal in browser
          jrnl                        # CLI journaling

          # Testing
          k6                          # Load testing
          iperf2                      # Network performance

          # Docs & Linting
          tlrc                        # tldr client
        ];

        fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

        # ── Services ──────────────────────────────────────────────────────────
        services.postgresql = {
          enable  = false;                    # using Docker instead
          dataDir = "/usr/local/var/postgres";
          package = pkgs.postgresql_16;       # overrides removed postgresql_13 default
        };

        # ── Homebrew ──────────────────────────────────────────────────────────
        homebrew = {
          enable = true;
          taps = [
            "osx-cross/avr"
            "coderabbit/tap"
          ];
          brews = [
            # Networking
            "iperf3"
            "mole"                    # SSH tunnel manager
            "mosquitto"               # MQTT broker
            "openssh"
            "libfido2"                # FIDO2 hardware key support
            "wireguard-tools"
            "tailscale"
            "watch"
            "supabase"

            # Runtimes
            "go"
            "nvm"                     # Node Version Manager
            "uv"                      # Python package manager

            # Dev tools
            "neovim"
            "mas"                     # Mac App Store CLI
            "ansible"
            "imagemagick"
            "httpie"
            "yazi"                    # Terminal file manager
            "yarn"
            "coderabbit"              # AI code review CLI
            "markdownlint-cli"

            # Python build deps
            "readline"
            "xz"

            # Embedded
            "cmake"
            "make"
            "avr-gcc"
            "avrdude"
            "minicom"                 # Serial terminal
            "minipro"                 # EPROM programmer
            "platformio"
            "arduino-cli"
            "bear"                    # Generates compile_commands.json

            # Media & TUI
            "mpv"
            "glow"                    # Markdown renderer
            "gum"                     # Shell script UI toolkit
            "ykman"                   # YubiKey manager
          ];
          casks = [
            # Communication
            "anydesk"
            "telegram"
            "whatsapp"
            "discord"
            # "spotify"

            # AI / Coding
            "codex"
            "claude-code"

            # Development
            "boop"                    # Developer toolsuite
            "ngrok"                   # Share local server
            "wireshark-app"
            "httpie-desktop"
            "postman"
            "pgadmin4"                # PostgreSQL client
            "kicad"
            "db-browser-for-sqlite"
            "docker-desktop"
            "raspberry-pi-imager"
            "autodesk-fusion"
            "balenaetcher"
            "mqttx"
            # "yubico-yubikey-manager" # End of Life

            # Notes & Productivity
            "obsidian"
            "notion"
            "libreoffice"
            "opal-app"
            "ticktick"
            "bitwarden"

            # Media & Editing
            "obs"
            "blender"
            "audacity"
            "vlc"
            # "iina"
            # "inkscape"
            # "diffusionbee"

            # 3D Printing
            "creality-print"
            "bambu-studio"
            # "ultimaker-cura"
            # "creality-slicer"
            # "orcaslicer"

            # Utilities
            "logi-options+"           # Logitech software
            "numi"                    # Calculator notepad
            "shottr"                  # Screenshots
            "the-unarchiver"
            "flux-app"                # Blue light filter
            "appcleaner"
            "nordvpn"
            "paragon-ntfs"
            "tailscale-app"
            "karabiner-elements"
            "yubico-authenticator"
            # "bartender"
            # "jordanbaird-ice"
            # "aerospace"

            # Browser
            "firefox"
            "google-chrome"

            # Terminal & Launcher
            "wezterm"
            "raycast"
          ];
          masApps = {
            "Pandan"                   = 1569600264; # Time tracking
            "Magnet"                   = 441258766;  # Window management
            "Steam Link"               = 1246969117; # Remote play
            "Amphetamine"              = 937984704;  # Keep screen on
            "Keynote"                  = 409183694;  # Presentations
            "Microsoft Remote Desktop" = 1295203466; # RDP
          };
          onActivation = {
            cleanup    = "zap";
            autoUpdate = true;
            upgrade    = true;
            extraFlags = [ "--force-cleanup" ]; # required by brew-bundle >=1.4
          };
        };

        # ── System ────────────────────────────────────────────────────────────
        nix.enable = false;           # Determinate manages the Nix daemon
        programs.zsh.enable = true;

        system.primaryUser        = "sai";
        system.stateVersion       = 5;
        system.configurationRevision = self.rev or self.dirtyRev or null;

        system.keyboard = {
          enableKeyMapping      = true;
          remapCapsLockToEscape = true;
        };

        security.pam.services.sudo_local.touchIdAuth = true;

        # ── macOS Defaults ────────────────────────────────────────────────────
        system.defaults = {
          dock = {
            autohide               = true;
            showhidden             = true;
            mru-spaces             = false;
            expose-animation-duration = 0.15;
            show-recents           = false;
            persistent-apps = [
              "/System/Applications/Apps.app"
              "/System/Applications/Photos.app"
              "/System/Applications/Messages.app"
              "/Applications/Whatsapp.app"
              "/System/Applications/FaceTime.app"
              "/System/Applications/Notes.app"
              "/System/Applications/App Store.app"
              "/Applications/Google Chrome.app"
              "/System/Applications/Mail.app"
              "/Applications/NordVPN.app"
              "/Applications/Tailscale.app"
              "/Applications/TickTick.app"
              "/Applications/Notion.app"
              "/Applications/WezTerm.app"
              "/System/Applications/Music.app"
              "/System/Applications/System Settings.app"
            ];
          };

          loginwindow.GuestEnabled = false;

          NSGlobalDomain = {
            AppleInterfaceStyle              = "Dark";
            KeyRepeat                        = 2;
            "com.apple.springing.enabled"    = true;
            "com.apple.springing.delay"      = 0.1;
            NSNavPanelExpandedStateForSaveMode  = true;
            NSDocumentSaveNewDocumentsToCloud   = false;
            PMPrintingExpandedStateForPrint     = true;
            AppleShowAllExtensions           = true;
          };

          screencapture = {
            location       = "~/Desktop/Screenshots";
            disable-shadow = true;
            type           = "png";
          };

          finder = {
            AppleShowAllFiles             = false;
            AppleShowAllExtensions        = true;
            FXEnableExtensionChangeWarning = false;
            _FXShowPosixPathInTitle        = false;
            FXRemoveOldTrashItems          = true;
            FXDefaultSearchScope           = "SCcf";
            FXPreferredViewStyle           = "clmv";
            ShowStatusBar                 = true;
            ShowPathbar                   = true;
            ShowMountedServersOnDesktop   = true;
            ShowHardDrivesOnDesktop       = false;
            ShowExternalHardDrivesOnDesktop = true;
          };

          controlcenter = {
            AirDrop              = false;
            BatteryShowPercentage = true;
            Bluetooth            = true;
            Display              = false;
            FocusModes           = true;
            NowPlaying           = true;
            Sound                = true;
          };
        };
      };
    in {
      darwinConfigurations."air" = nix-darwin.lib.darwinSystem {
        modules = [ configuration ];
      };
    };
}
