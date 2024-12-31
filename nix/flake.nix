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
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager}:
  let
    username = "zigapk";
    configuration = { pkgs, ... }: {
      nixpkgs.config.allowUnfree = true;

      environment.systemPackages =
        [ pkgs.neovim
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
          pkgs.ripgrep
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
        ];

      users.users.zigapk = {
        name = username;
        home = "/Users/zigapk";
      };
      
      homebrew = {
        enable = true;
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
        casks = [
          "ghostty"
          "1password"
          "karabiner-elements"
          "transmission"
        ];
        masApps = {
          "ChatGPT" = 6448311069;
          "TickTick" = 966085870;
          "Yoink" = 457622435;
          "Xcode" = 497799835;
          "Notability" = 360593530;
        };
      };

      services = {
        tailscale.enable = true;
      };

      # Mac settings
      system.defaults = import ./preferences.nix { inherit pkgs; };
      security.pam.enableSudoTouchIdAuth = true;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

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
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.zigapk = import ./home/home.nix;
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
