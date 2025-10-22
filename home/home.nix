{ pkgs
, username
, homeDirectory
, emoji
, ...
}:
let
  onePassPath = "~/.1password/agent.sock";
  cursorTheme = "Bibata-Modern-Ice";
  cursorSize = 24;
  papirus = pkgs.papirus-icon-theme;
in
{
  home = {
    inherit username;
    inherit homeDirectory;

    packages = with pkgs; [
      papirus
    ];

    stateVersion = "25.05";
  };

  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = cursorTheme;
    };
    theme = {
      name = "Adwaita";
      package = pkgs.gtk3;
    };
    iconTheme = {
      package = papirus;
      name = "Papirus";
    };
  };

  imports = [
    ./zsh.nix
  ];
  programs = {
    home-manager.enable = true;
    kitty.enable = true;

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
    nixvim = import ./nixvim.nix { inherit pkgs; };

    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          extraOptions = {
            IdentityAgent = onePassPath;
          };
        };
      };
    };

    ghostty = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        font-size = 12;
      };
    };
  };
}
