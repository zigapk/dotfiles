{ pkgs
, home-manager
, nix-homebrew
, username
, homeDirectory
, config
, nixvim
, ...
} @ inputs: {
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    obsidian
    rectangle
    arc-browser
    inkscape
    gimp
    imagemagick
    vlc-bin
    vscode
    android-file-transfer
    raycast
    # TODO: install ghostty from nixpkgs
    # ghostty
  ];

  # User-related config
  users.users.zigapk = {
    name = username;
    home = homeDirectory;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [
      nixvim.homeModules.nixvim
    ];
    users.zigapk = import ../home/home.nix {
      emoji = "🦄";
      inherit username homeDirectory config pkgs;
    };
  };

  # Enable nix-homebrew
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = username;
    autoMigrate = true;
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
      "microsoft-teams"
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
    # Home manager modules
    home-manager.darwinModules.home-manager
    # Add nix-homebrew
    nix-homebrew.darwinModules.nix-homebrew
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
}
