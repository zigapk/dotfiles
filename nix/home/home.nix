{ config
, pkgs
, lib
, vars
, ...
}: {
  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "zigapk";
    homeDirectory = "/Users/zigapk";
    file.".config/karabiner/karabiner.json".text = builtins.readFile ../../config/karabiner.json;
    file.".config/ghostty/config".text = builtins.readFile ../../config/ghostty/config;

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "24.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs = {
    git = import ./git.nix { inherit config pkgs; };
    zsh = import ./zsh.nix { inherit config pkgs; };
    starship = import ./starship.nix { inherit config pkgs; };
    atuin = import ./atuin.nix { inherit config pkgs; };
    zoxide = import ./zoxide.nix { inherit config pkgs; };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    nixvim = import ./nixvim.nix { inherit config pkgs; };
  };
}
