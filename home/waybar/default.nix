_: {
  programs.waybar = {
    enable = true;
    settings.main = {
      # Bar placement
      "layer" = "top";
      "position" = "top";
      "margin-top" = 8;
      "margin-bottom" = 4;

      # Modules
      "modules-left" = [
        "clock"
        "custom/weather"
      ];
      "modules-center" = [ "hyprland/workspaces" ];
      "modules-right" = [
        "pulseaudio"
        "battery"
        "custom/tlp"
        "hyprland/language"
        "network"
      ];

      # Battery status
      battery = {
        format = "{icon} {capacity}%";
        "format-charging" = "󰂄 {capacity}%";
        "format-icons" = [
          "󰁺"
          "󰁻"
          "󰁼"
          "󰁽"
          "󰁾"
          "󰁿"
          "󰂀"
          "󰂁"
          "󰂂"
          "󰁹"
        ];
      };

      # This custom module shows 🏎️ or 🦥, toggles on click,
      # and auto‑refreshes on UPower PropertiesChanged.
      "custom/tlp" = {
        exec = "$HOME/.config/waybar/scripts/tlp.sh";
        on-click = "$HOME/.config/waybar/scripts/tlp.sh toggle";
        interval = 120;
        signal = 7;
        dbus = {
          service = "org.freedesktop.UPower";
          path = "/org/freedesktop/UPower/devices/line_power_ACAD";
          interface = "org.freedesktop.DBus.Properties";
          member = "PropertiesChanged";
        };

        format = "{}";
      };

      # Clock
      clock = {
        format = "{:%H:%M}";
        "format-alt" = "{:%a, %d. %b %H:%M}";
        tooltip = true;
        "tooltip-format" = "{:%d %B %Y}";
      };

      # Audio volume
      pulseaudio = {
        format = "{icon}  {volume}%";
        "format-bluetooth" = "󰂱  {volume}%";
        "format-muted" = "󰖁";
        "scroll-step" = 1;
        "on-click" = "pavucontrol";
        "ignored-sinks" = [ "Easy Effects Sink" ];
        "format-icons" = {
          headphone = "  ";
          "hands-free" = " ";
          headset = "󰋎 ";
          phone = " ";
          portable = " ";
          car = "";
          default = [
            "󰖀"
            "󰕾"
          ];
        };
      };

      # Network status
      network = {
        interface = "wlp192s0";
        format = "{ifname}";
        "format-wifi" = "{icon}  {essid}";
        "format-ethernet" = "󰈀   {ipaddr}/{cidr}";
        "format-disconnected" = "󰤭 ";
        "max-length" = 50;
        "format-icons" = [
          "󰤯"
          "󰤟"
          "󰤢"
          "󰤥"
          "󰤨"
        ];
        on-click = "ghostty -e nmtui";
        "tooltip" = true;
        "tooltip-format" = "{ifname}: {ipaddr}/{cidr}";
      };

      # Hyprland workspaces
      "hyprland/workspaces" = {
        # show workspace number (e.g. 1, 2, 3…)
        format = "{name}";
        on-click = "activate";
        # keep them sorted by number
        "sort-by-number" = true;
      };

      # Weather
      "custom/weather" = {
        exec = "$HOME/.config/waybar/scripts/get_weather.sh Ljubljana+Slovenia";
        "return-type" = "json";
        format = "{}";
        tooltip = true;
        interval = 3600;
      };

      "hyprland/language" = {
        "format" = "{}";
        "format-en" = "US";
        "format-sl-us" = "SI";
        on-click = "hyprctl switchxkblayout current next";
      };
    };
  };

  # Link stylesheet
  xdg.configFile."waybar/style.css".source = ./style.css;
  xdg.configFile."waybar/scripts/get_weather.sh".source = ./scripts/get_weather.sh;
  xdg.configFile."waybar/scripts/tlp.sh".source = ./scripts/tlp.sh;
}
