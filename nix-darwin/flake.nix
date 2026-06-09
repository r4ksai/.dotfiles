{
  description = "Sai's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
    let
      configuration = { pkgs, ... }: {
        nixpkgs.config.allowUnfree = true;
        environment.systemPackages =
          [ 
            # Development
            pkgs.lazydocker
            pkgs.lazygit # Interactive terminal git
            pkgs.lazysql # Interactive terminal sql
            pkgs.commitizen # Commit message creator
            pkgs.tig # Terminal git
            pkgs.pyenv # Manage python environment

            # Testing
            pkgs.k6 # Test API endpoints with JS
            pkgs.iperf2 # Test Network performance

            # Stats
            pkgs.neofetch
            pkgs.btop # "htop" alternative
            pkgs.htop # "top" command replacement

            # Essentials
            # pkgs.neovim
            pkgs.git
            pkgs.tmux # Terminal splitting

            # Window Manager
            # pkgs.aerospace # Tiling window manager

            # Terminal
            pkgs.fish # Fish shell
            pkgs.lsd # "ls" command replacement
            pkgs.bat # "cat" command replacement
            pkgs.fzf # Fuzzy Finder
            pkgs.peco # Create an interrative list from output
            pkgs.fd # "find" command replacement
            pkgs.ripgrep # Search inside files for a pattern
            pkgs.ttyper # Monkey type cli edition

            # Networking
            pkgs.wget # "curl" command replacement
            pkgs.nmap # Network Vuln Testing
            pkgs.yt-dlp # Download Youtube videos

            # Utils
            pkgs.reattach-to-user-namespace
            pkgs.ffmpeg # FFMPEG : Video stuff
            pkgs.gnupg # GPG
            pkgs.fdupes # Get duplicates
            pkgs.ttyd # Terminal over browser
            pkgs.jrnl # Journaling app

            # Docs
            pkgs.tlrc # "man" command replacement

          ];

        fonts.packages = [
          pkgs.nerd-fonts.jetbrains-mono
        ];

        services = {
          postgresql = {
            enable = true;
            dataDir = "/usr/local/var/postgres";
            package = pkgs.postgresql_13;
          };
          # prometheus.exporters.node.enable = true;
        };

        homebrew = {
          enable = true;
          taps = [
            "osx-cross/avr"
          ];
          brews = [
            # Networking
            "iperf3"
            "mole"           # SSH tunnel manager
            "mosquitto"      # MQTT broker
            "openssh"
            "libfido2"       # FIDO2 hardware key support
            "wireguard-tools"
            "tailscale"
            "watch"
            "supabase"

            # Runtimes
            "go"
            "nvm"            # Node Version Manager
            "uv"             # Fast Python package manager

            # Dev tools
            "neovim"
            "mas"            # Mac App Store CLI
            "ansible"
            "imagemagick"
            "httpie"         # HTTP client
            "yazi"           # Terminal file manager
            "yarn"

            # Python build deps
            "readline"
            "xz"

            # Embedded
            "cmake"
            "make"
            "avr-gcc"
            "avrdude"
            "minicom"        # Serial terminal
            "minipro"        # EPROM programmer
            "platformio"
            "arduino-cli"
            "bear"           # Generates compile_commands.json

            # Media
            "mpv"            # CLI video player
            "glow"
            "gum"
            "ykman"
          ];
          casks = [
            "anydesk"
            "balenaetcher"
            "mqttx"
            "telegram"
            # "spotify" # Music

            "codex"
            "claude-code"

            # Development
            "boop" # Developer toolsuite
            # "yubico-yubikey-manager" -> End of Life
            "ngrok" # Share local web page
            "wireshark-app" # Test network packets
            "httpie-desktop" # API testing
            "postman" # API testing - Advance
            "pgadmin4" # Postgresql client
            "kicad"
            "db-browser-for-sqlite"
            "docker-desktop"
            # "diffusionbee" # AI Image Generator
            "raspberry-pi-imager"
            "autodesk-fusion"

            # Note Taking
            "obsidian"
            "notion"
            # "affine"

            # Productivity
            "libreoffice"
            "opal-app"

            # Editing
            # "inkscape"
            "obs"
            "blender"
            "audacity"

            # 3D Printing
            "creality-print"
            # "ultimaker-cura"
            # "creality-slicer"
            "bambu-studio"
            # "orcaslicer"

            # Utilities
            "logi-options+" # Logitech software
            "numi" # Calculator Notepad
            "shottr" # Screenshots
            "the-unarchiver" # GUI Extractor
            "flux-app" # Blue light filter
            "appcleaner" # Remove app completely
            # "bartender" # Menu bar items manager
            "nordvpn"
            "paragon-ntfs"
            "tailscale-app"
            # "jordanbaird-ice" # Menubar Organisor
            # "aerospace" # Tiling window manager
            "karabiner-elements"
            "whatsapp"
            "bitwarden"
            "ticktick"
            "yubico-authenticator"

            # Browser
            "firefox"
            "google-chrome"

            # Terminal
            "wezterm"
            "raycast"

            # Entertainment
            # "iina" # VLC Alternative
            "vlc"
            "discord"
            # "steam"
          ];
          masApps = {
            "Pandan" = 1569600264; # Time tracking
            "Magnet" = 441258766; # Window splitting manager
            "Steam Link" = 1246969117; # Remote play steam
            "Amphetamine" = 937984704; # Keep the screen on
            "Keynote" = 409183694; # Create Presentation
            "Microsoft Remote Desktop" = 1295203466; # RDP Client
          };
          onActivation.cleanup = "zap";
          onActivation.autoUpdate = true;
          onActivation.upgrade = true;
        };

        # postgresql_13 removed in nixpkgs 25.11 — override default to unblock build.
        # Service is disabled; using Docker for postgres instead.
        services.postgresql.package = pkgs.postgresql_16;
        # services.postgresql.enable = true;

        # Determinate manages the Nix daemon; nix-darwin must not conflict.
        nix.enable = false;

        # Enable alternative shell support in nix-darwin.
        programs.zsh.enable = true;

        system.keyboard = {
          enableKeyMapping = true;
          remapCapsLockToEscape = true;
        };

        security.pam.services.sudo_local.touchIdAuth = true;

        system.primaryUser = "sai";

        system.defaults = {
          dock.autohide = true;
          dock.showhidden = true;
          dock.mru-spaces = false;
          dock.expose-animation-duration = 0.15;
          dock.show-recents = false;
          dock.persistent-apps = [
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
          loginwindow.GuestEnabled = false;

          NSGlobalDomain.AppleInterfaceStyle = "Dark";
          NSGlobalDomain.KeyRepeat = 2;
          NSGlobalDomain."com.apple.springing.enabled" = true;
          NSGlobalDomain."com.apple.springing.delay" = 0.1;
          NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
          NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
          NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
          NSGlobalDomain.AppleShowAllExtensions = true;

          screencapture.location = "~/Desktop/Screenshots";
          screencapture.disable-shadow = true;
          screencapture.type = "png";

          finder.AppleShowAllFiles = false;
          finder.AppleShowAllExtensions = true;
          finder.FXEnableExtensionChangeWarning = false;
          finder._FXShowPosixPathInTitle = false;
          finder.FXRemoveOldTrashItems = true;
          finder.FXDefaultSearchScope = "SCcf";
          finder.FXPreferredViewStyle = "clmv";
          finder.ShowStatusBar = true;
          finder.ShowPathbar = true;
          finder.ShowMountedServersOnDesktop = true;
          finder.ShowHardDrivesOnDesktop = false;
          finder.ShowExternalHardDrivesOnDesktop = true;

          controlcenter.AirDrop = false;
          controlcenter.BatteryShowPercentage = true;
          controlcenter.Bluetooth = true;
          controlcenter.Display = false;
          controlcenter.FocusModes = true;
          controlcenter.NowPlaying = true;
          controlcenter.Sound = true;
        };

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
      };
    in
      {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."air" = nix-darwin.lib.darwinSystem {
        modules = [ configuration ];
      };
    };
}
