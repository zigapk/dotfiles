{
  pkgs,
  ...
}:
let
  onePassPath = "~/.1password/agent.sock";
  cursorTheme = "Bibata-Modern-Ice";
  papirus = pkgs.papirus-icon-theme;
in
{
  home.packages = [
    papirus
    pkgs.f1viewer
    pkgs.mpv
    # Clipboard CLIs that herdr and omp shell out to for copy/paste. Without
    # them, image/text paste silently reports an empty clipboard.
    pkgs.wl-clipboard
    pkgs.xclip
  ];

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
    kitty.enable = true;

    # herdr and omp read the clipboard by shelling out to wl-paste/xclip. On
    # GNOME/Mutter the Wayland path (wl-paste, native data-control) hangs
    # because the compositor exposes no data-control protocol, so clipboard
    # image/text paste reports an empty clipboard. Unsetting WAYLAND_DISPLAY
    # forces the working XWayland path (xclip reads the Mutter-bridged
    # selection). These are terminal apps that need no Wayland rendering, so
    # any GUI they spawn simply falls back to XWayland.
    zsh.shellAliases = {
      herdr = "env -u WAYLAND_DISPLAY herdr";
      omp = "env -u WAYLAND_DISPLAY omp";
    };

    # Point ssh + git signing at the local 1Password agent socket. Also forward
    # that agent to kibla so `herdr --remote kibla` and manual ssh carry the
    # 1Password agent, letting kibla sign/authenticate with a prompt on kanta.
    ssh.settings = {
      "*".IdentityAgent = onePassPath;
      kibla.ForwardAgent = "yes";
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
  };
}
