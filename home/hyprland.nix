_: {
  programs.kitty.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;

    settings = {
      "$mainMod" = "SUPER";

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        resize_on_border = true;
      };

      bind =
        [
          # Terminal, filemanager, browser, etc.
          "$mainMod, RETURN, exec, ghostty"
          "$mainMod, Q, killactive"
          "$mainMod, M, exit"
          "$mainMod, E, exec, thunar"
          "$mainMod, B, exec, firefox"
          "$mainMod SHIFT, B, exec, ~/.config/ml4w/scripts/reload-waybar.sh"
          "$mainMod SHIFT, W, exec, ~/.config/ml4w/scripts/reload-hyprpaper.sh"

          # UI & Tiling
          "$mainMod, T, togglefloating"
          "$mainMod, F, fullscreen"
          "$mainMod CTRL, RETURN, exec, rofi -show drun"
          "$mainMod, P, pseudo"
          "$mainMod, O, togglesplit"

          # Volume & Brightness
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
          ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
          ", XF86WLAN, exec, nmcli radio wifi toggle"
          ", XF86Refresh, exec, xdotool key F5"

          # Move focus with hjkl
          "$mainMod, H, movefocus, l"
          "$mainMod, L, movefocus, r"
          "$mainMod, K, movefocus, u"
          "$mainMod, J, movefocus, d"

          # Move window with hjkl
          "$mainMod SHIFT, H, movewindow, l"
          "$mainMod SHIFT, L, movewindow, r"
          "$mainMod SHIFT, K, movewindow, u"
          "$mainMod SHIFT, J, movewindow, d"
        ]
        ++
        # Workspaces [switch + move]
        (builtins.concatLists (builtins.genList
          (i:
            let
              ws = toString (i + 1);
              code = "code:1${toString i}";
            in
            [
              "$mainMod, ${code}, workspace, ${ws}"
              "$mainMod SHIFT, ${code}, movetoworkspace, ${ws}"
            ])
          9));

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      input = {
        kb_layout = "us,si";
        follow_mouse = 1;
        kb_options = "grp:alt_shift_toggle,ctrl:nocaps";
      };

      decoration = {
        rounding = 10;
        active_opacity = 0.98;
        inactive_opacity = 0.95;
        blur = {
          enabled = true;
          size = 6;
          passes = 1;
          new_optimizations = true;
          ignore_opacity = true;
          xray = false;
        };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.38, 0.04, 1, 0.07"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
          "softAcDecel, 0.26, 0.26, 0.15, 1"
          "md2, 0.4, 0, 0.2, 1"
        ];

        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "windowsIn, 1, 3, md3_decel, popin 60%"
          "windowsOut, 1, 3, md3_accel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 3, md3_decel"
          # "layers, 1, 2, md3_decel, slide"
          "layersIn, 1, 3, menu_decel, slide"
          "layersOut, 1, 1.6, menu_accel"
          "fadeLayersIn, 1, 2, menu_decel"
          "fadeLayersOut, 1, 4.5, menu_accel"
          "workspaces, 1, 7, menu_decel, slide"
          # "workspaces, 1, 2.5, softAcDecel, slide"
          # "workspaces, 1, 7, menu_decel, slidefade 15%"
          # "specialWorkspace, 1, 3, md3_decel, slidefadevert 15%"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [ "~/dotfiles/wallpapers/default.webp" ];
      wallpaper = [ ",~/dotfiles/wallpapers/default.webp" ];
    };
  };
}
