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
