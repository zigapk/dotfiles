{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs @ { nix-darwin
    , nixpkgs
    , nix-homebrew
    , home-manager
    , nixvim
    , ...
    }:
    let
      username = "zigapk";
      configuration = { pkgs, ... }: {
        nixpkgs.config.allowUnfree = true;

        # System packages
        environment.systemPackages = [
          pkgs.wget
          pkgs.tree
          pkgs.git
          pkgs.python3
          pkgs.python3Packages.pip
          pkgs.python3Packages.virtualenv
          pkgs.obsidian
          pkgs.btop
          pkgs.eza
          pkgs.fzf
          pkgs.bat
          pkgs.ripgrep
          pkgs.cloc
          pkgs.rectangle
          pkgs.arc-browser
          pkgs.inkscape
          pkgs.gimp
          pkgs.imagemagick
          pkgs.vlc-bin
          pkgs.vscode
          pkgs.android-file-transfer
          pkgs.jq
          pkgs.raycast
          pkgs.lazygit
          pkgs.neofetch
          # TODO: install ghostty from nixpkgs
          # pkgs.ghostty
          pkgs.yarn
          pkgs.nodejs_22
        ];

        # User-related config
        users.users.zigapk = {
          name = username;
          home = "/Users/" + username;
        };

        # Homebrew for the packages not available in nixpkgs
        homebrew = {
          enable = true;

          # Delete everything not specified here and automatically update & upgrade everything
          onActivation = {
            cleanup = "zap";
            autoUpdate = true;
            upgrade = true;
          };
          casks = [
            "1password"
            "karabiner-elements"
            "transmission"
            "ghostty" # TODO: install ghostty from nixpkgs
            "anydesk"
          ];
          # App-store apps
          masApps = {
            "ChatGPT" = 6448311069;
            "TickTick" = 966085870;
            "Yoink" = 457622435;
            "Xcode" = 497799835;
            "Notability" = 360593530;
          };
        };

        # Nix config
        nix.settings = {
          trusted-users = [ "@admin" ];
          # Necessary for using flakes on this system.
          experimental-features = "nix-command flakes";
        };

        services = {
          tailscale.enable = true;
        };

        imports = [
          # Sketchybar (status bar)
          ./sketchybar/default.nix
          # Aerospace tiling window manager
          ./aerospace.nix
          # Linux builder for non-darwin targets
          ./linux-builder.nix
        ];

        # Mac settings
        system.defaults = import ./preferences.nix { inherit pkgs; };
        security.pam.enableSudoTouchIdAuth = true;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
      };
    in
    {
      # Unicorn (my M1 MacBook Pro)
      darwinConfigurations."unicorn" = nix-darwin.lib.darwinSystem {
        modules = [
          # Base config
          configuration
          # Add home-manager
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = [
                nixvim.homeManagerModules.nixvim
              ];
              users.zigapk = import ./home/home.nix;
            };
          }
          # Add nix-homebrew
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = username;
              autoMigrate = true;
            };
          }
        ];
      };
    };
}
