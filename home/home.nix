{ pkgs
, username
, homeDirectory
, emoji
, ...
}: {
  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    inherit username;
    inherit homeDirectory;

    # On darwin, copy some config files
    file =
      if pkgs.stdenv.isDarwin
      then {
        ".config/karabiner/karabiner.json".text = builtins.readFile ../darwin/config/karabiner.json;
        ".config/ghostty/config".text = builtins.readFile ../darwin/config/ghostty/config;
      }
      else { };

    stateVersion = "25.05";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./zsh.nix
    ./hyprland.nix
  ];

  programs = {
    git = import ./git.nix { inherit pkgs; };
    carapace = {
      enable = true;
      enableZshIntegration = true;
    };
    starship = import ./starship.nix { inherit emoji; };

    atuin = import ./atuin.nix { inherit pkgs; };
    zoxide = import ./zoxide.nix { inherit pkgs; };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    ghostty = import ./ghostty.nix { inherit pkgs; };
    nixvim = import ./nixvim.nix { inherit pkgs; };
  };
}
