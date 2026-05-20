{
  pkgs,
  pkgs-unstable,
  username,
  homeDirectory,
  emoji,
  lib,
  ...
}:
let
  onePassPath = "~/.1password/agent.sock";
  cursorTheme = "Bibata-Modern-Ice";
  papirus = pkgs.papirus-icon-theme;
in
{
  home = {
    inherit username;
    inherit homeDirectory;

    packages = with pkgs; [
      papirus
      diffnav
    ];

    stateVersion = "25.11";
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



  xdg.desktopEntries.chromium = {
    name = "Chromium";
    genericName = "Web Browser";
    comment = "Access the Internet";
    exec = "chromium %U";
    icon = "chromium";
    type = "Application";
    categories = [
      "Network"
      "WebBrowser"
    ];
    mimeType = [
      "application/pdf"
      "application/rdf+xml"
      "application/rss+xml"
      "application/xhtml+xml"
      "application/xhtml_xml"
      "application/xml"
      "image/gif"
      "image/jpeg"
      "image/png"
      "image/webp"
      "text/html"
      "text/xml"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "x-scheme-handler/webcal"
      "x-scheme-handler/mailto"
      "x-scheme-handler/about"
      "x-scheme-handler/unknown"
    ];
    startupNotify = true;
    settings = {
      StartupWMClass = "chromium-browser";
    };
    actions = {
      new-window = {
        name = "New Window";
        exec = "chromium";
      };
      new-private-window = {
        name = "New Incognito Window";
        exec = "chromium --incognito";
      };
    };
  };

  programs = {
    home-manager.enable = true;
    kitty.enable = true;

    git = import ./git.nix { inherit pkgs; };
    starship = import ./starship.nix { inherit emoji; };
    atuin = import ./atuin.nix { inherit pkgs; };
    zoxide = import ./zoxide.nix { inherit pkgs; };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    nixvim = import ./nixvim.nix { inherit pkgs lib; };

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
        keybind = [
          "shift+enter=text:\\x1b\\r"
          "shift+tab=text:\\x1b[Z"
        ];
      };
    };

    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };

    opencode = {
      enable = true;
      package = pkgs-unstable.opencode;
      settings = {
        plugin = [ "opencode-claude-auth@latest" ];
        agent = {
          build = {
            enable1mContext = true;
          };
        };
      };
    };
  };
}
