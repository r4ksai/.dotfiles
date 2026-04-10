{
  description = "Sai's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
    let
      configuration = { pkgs, ... }: {
        nixpkgs.config.allowUnfree = true;
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
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
            pkgs.fish # "zsh" shell replacement
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

            pkgs.ttyd # Terminal over Browser
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
          aerospace.enable = false;
          # prometheus.exporters.node.enable = true;
        };

        homebrew = {
          enable = true;
          taps = [
            "osx-cross/avr"
          ];
          brews = [
            "iperf3"
            "mole"
            "watch"
            "mosquitto"

            # "coreutils"
            "openssh"
            "libfido2"

            "go" # Go
            "nvm" # Node Version Manager
            "mas" # Install Mac Stuff from Terminal
            "neovim"
            "tailscale"
            "ansible"
            "imagemagick"

            # Python stuff
            "readline"
            "xz"
            "httpie"
            "yazi"
            "uv"
            "wireguard-tools"

            # Embedded stuff
            "cmake"
            "make"
            "avr-gcc"
            "avrdude"
            "minicom"
            "minipro"
            "platformio"
            "arduino-cli"
            "bear" # Creates compile commands - bear -- <your-build-command>

            "mpv" # CLI Video player
          ];
          casks = [
            "anydesk"
            "balenaetcher"
            "mqttx"
            "telegram"
            # "spotify" # Music

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
            # "diffusionbee" # AI Image Generator
            # "raspberry-pi-imager"

            # Note Taking
            # "obsidian"
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
            # "creality-print"
            # "ultimaker-cura"
            "creality-slicer"
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
            # "Silicio" = 933627574; # Spotify Client
          };
          onActivation.cleanup = "zap";
          onActivation.autoUpdate = true;
          onActivation.upgrade = true;
        };

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Enable alternative shell support in nix-darwin.
        programs.zsh.enable = true;

        system.keyboard = {
          enableKeyMapping=true;
          remapCapsLockToEscape=true;
        };

        security.pam.services.sudo_local.touchIdAuth = true;

        system.primaryUser = "sai";

        system.defaults = {
          dock.autohide=true;
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
            # "/Applications/AFFiNE.app"
            # "/Applications/Obsidian.app"
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

          # "com.apple.appstore" = {
          #   InAppReviewEnabled = 0;
          # };
          #
          # "com.apple.desktopservices" = {
          #   DSDontWriteNetworkStores = true;
          #   DSDontWriteUSBStores = true;
          # };

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
