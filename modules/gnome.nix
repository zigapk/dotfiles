{
  pkgs,
  lib,
  ...
}: {
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = with pkgs; [];

  programs.dconf.profiles.user.databases = [
    {
      lockAll = true;
      settings = {
        "org/gnome/desktop/interface" = {
          enable-hot-corners = false;
        };
        "org/gnome/desktop/peripherals" = {
          delay = lib.gvariant.mkUint32 100;
          repeat = true;
          repeat-interval = lib.gvariant.mkUint32 30;
        };
        "org/gnome/desktop/peripherals/touchpad" = {
          tap-to-click = true;
          two-finger-scrolling-enabled = true;
          natural-scroll = true;
          speed = 0.0;
          disable-while-typing = true;
          click-method = "fingers";
          scroll-factor = 0.5;
        };
        "org/gnome/desktop/peripherals/mouse" = {
          speed = 0.0;
          accel-profile = "default";
        };

        "org.gnome.desktop.wm.preferences" = {
          # Focus follows mouse
          focus-mode = "sloppy";
        };

        "org/gnome/desktop/wm/keybindings" = {
          switch-to-workspace-1 = ["<Super>1"];
          switch-to-workspace-2 = ["<Super>2"];
          switch-to-workspace-3 = ["<Super>3"];
          switch-to-workspace-4 = ["<Super>4"];
          switch-to-workspace-5 = ["<Super>5"];
          switch-to-workspace-6 = ["<Super>6"];
          move-to-workspace-1 = ["<Shift><Super>1"];
          move-to-workspace-2 = ["<Shift><Super>2"];
          move-to-workspace-3 = ["<Shift><Super>3"];
          move-to-workspace-4 = ["<Shift><Super>4"];
          move-to-workspace-5 = ["<Shift><Super>5"];
          move-to-workspace-6 = ["<Shift><Super>6"];
          close = ["<Super>q"];
          switch-input-source = ["<Alt>Escape"];
          switch-input-source-backward = ["<Shift><Alt>Escape"];
          toggle-quick-settings = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
          switch-applications = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
          switch-applications-backward = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
          switch-windows = ["<Alt>Tab" "<Super>Tab"];
          switch-windows-backward = ["<Shift><Alt>Tab" "<Shift><Super>Tab"];
        };

        "org/gnome/settings-daemon/plugins/power" = {
          power-button-action = "lock";
          sleep-inactive-battery-timeout = lib.gvariant.mkUint32 900;
          sleep-inactive-ac-timeout = lib.gvariant.mkUint32 7200;
        };
        "org/gnome/desktop/input-sources" = {
          sources = [
            (lib.gvariant.mkTuple [
              "xkb"
              "us"
            ])
            (lib.gvariant.mkTuple [
              "xkb"
              "si+us"
            ])
          ];
        };

        "org/gnome/shell" = {
          enabled-extensions = [
            pkgs.gnomeExtensions.focus-changer.extensionUuid
            pkgs.gnomeExtensions.clipboard-indicator.extensionUuid
            pkgs.gnomeExtensions.blur-my-shell.extensionUuid
            pkgs.gnomeExtensions.wallpaper-slideshow.extensionUuid
            pkgs.gnomeExtensions.bluetooth-battery-meter.extensionUuid
          ];
        };
        "org/gnome/shell/keybindings" = {
          toggle-message-tray = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        };
        "org/gnome/shell/extensions/clipboard-indicator" = {
          history-size = lib.gvariant.mkInt32 100;
          toggle-menu = ["<Super>v"];
          notify-on-copy = false;
          paste-on-select = true;
          excluded-apps = ["1Password"];
          topbar-preview-size = lib.gvariant.mkInt32 48;
        };
        "org/gnome/shell/extensions/blur-my-shell" = {
          "applications/blur" = true;
          "applications/whitelist" = ["com.mitchellh.ghostty"];
          "applications/dynamic-opacity" = false;
          "applications/sigma" = lib.gvariant.mkUint32 26;
          "applications/opacity" = lib.gvariant.mkUint32 245;
        };
        "org/gnome/shell/extensions/azwallpaper" = {
          "slideshow-directory" = "/home/zigapk/dotfiles/wallpapers";
          "slideshow-slide-duration" = lib.gvariant.mkTuple [
            (lib.gvariant.mkUint64 2)
            (lib.gvariant.mkUint64 0)
            (lib.gvariant.mkUint64 0)
          ];
        };
        "org/gnomede/desktop/session" = {
          idle-delay = lib.gvariant.mkUint32 0;
        };
        "org/gnome/mutter" = {
          experimental-features = [
            "scale-monitor-framebuffer"
            "xwayland-native-scaling"
          ];
          overlay-key = "Super_L";
        };

        # Custom keybindings
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
          ];
          www = ["<Super>b"];
          search = ["<Super>space"];
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          name = "Launch ghostty";
          command = "ghostty";
          binding = "<Super>Return";
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
          name = "Launch Slack";
          command = "slack";
          binding = "<Super>s";
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
          name = "Launch 1password";
          command = "1password";
          binding = "<Super>i";
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
          name = "Launch nautilus";
          command = "nautilus";
          binding = "<Super>f";
        };
      };
    }
  ];

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita";
  };
}
