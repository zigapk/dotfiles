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

    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = cursorTheme;
      size = cursorSize;
      gtk.enable = true;
      x11.enable = true;
      hyprcursor = {
        enable = true;
        size = cursorSize;
      };
    };

    packages = with pkgs; [
      hyprcursor
      bibata-cursors
      papirus
      libsForQt5.qt5ct
      qt6ct
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
    ./hyprland.nix
    ./electron.nix
    ./waybar
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

    walker = {
      enable = true;
      runAsService = true;

      config = {
        close_when_opened = true;
        disabled = [
          "runner"
          "websearch"
          "ssh"
        ];
        app_launch_prefix = "uwsm app -- ";
        builtins = {
          hyprland_keybinds = {
            show_sub_when_single = true;
            path = "~/.config/hypr/hyprland.conf";
            weight = 5;
            name = "hyprland_keybinds";
            placeholder = "Hyprland Keybinds";
            switcher_only = true;
            hidden = true;
          };
          xdph_picker = {
            hidden = true;
            weight = 5;
            placeholder = "Screen/Window Picker";
            show_sub_when_single = true;
            name = "xdphpicker";
            switcher_only = true;
          };
          calc = {
            require_number = true;
            weight = 5;
            name = "Calculator";
            icon = "accessories-calculator";
            placeholder = "Calculator";
            min_chars = 3;
            prefix = "=";
          };
          clipboard = {
            always_put_new_on_top = true;
            weight = 5;
            name = "clipboard";
            avoid_line_breaks = true;
            placeholder = "Clipboard";
            image_height = 300;
            switcher_only = false;
            hidden = false;
            prefix = "@";
          };
          emojis = {
            exec = "wl-copy";
            weight = 5;
            name = "Emojis";
            placeholder = "Emojis";
            switcher_only = true;
            history = true;
            typeahead = true;
            show_unqualified = false;
            prefix = ":";
          };
          finder = {
            use_fd = true;
            fd_flags = "--ignore-vcs --type file --type directory";
            cmd_alt = "xdg-open $(dirname ~/%RESULT%)";
            weight = 5;
            icon = "file";
            name = "Finder";
            placeholder = "Finder";
            switcher_only = true;
            ignore_gitignore = true;
            refresh = true;
            concurrency = 8;
            show_icon_when_single = true;
            preview_images = true;
            hidden = false;
            prefix = ".";
          };
        };
      };
    };
  };

  # Notification daemon
  services.dunst = {
    enable = true;
    settings = {
      global = {
        markup = "full";
        icon_corner_radius = 8;
        format = "<b>%a</b>\n%b";
        width = 256;
        height = 48;
        offset = "24x16";
        corner_radius = 12;
        font = "Droid Sans Mono 10";
        frame_color = "#1e1e2e";
        background = "#1e1e2e";
        icon_size = 64;
        padding = 16;
        horizontal_padding = 8;
        transparency = 20;
        timeout = 6;
        show_indicators = false;
        mouse_left_click = "do_action, close_current";
      };
    };
    iconTheme = {
      name = "Papirus";
      package = papirus;
      size = "64x64";
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
  };
}
