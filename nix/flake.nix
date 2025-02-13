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

        users.users.zigapk = {
          name = username;
          home = "/Users/zigapk";
        };

        homebrew = {
          enable = true;
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
          masApps = {
            "ChatGPT" = 6448311069;
            "TickTick" = 966085870;
            "Yoink" = 457622435;
            "Xcode" = 497799835;
            "Notability" = 360593530;
          };
        };

        nix.linux-builder = {
          enable = true;
          package = pkgs.darwin.linux-builder-x86_64;
          ephemeral = true;
          maxJobs = 4;
          config = {
            virtualisation = {
              darwin-builder = {
                diskSize = 40 * 1024;
                memorySize = 2 * 1024;
              };
              cores = 2;
            };
          };
        };
        nix.settings = {
          trusted-users = [ "@admin" ];

          # Necessary for using flakes on this system.
          experimental-features = "nix-command flakes";
        };

        services = {
          tailscale.enable = true;
        };

        imports = [
          ./sketchybar/default.nix
          ./aerospace.nix
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
      # Build darwin flake using:
      darwinConfigurations."unicorn" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
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
