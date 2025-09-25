{ pkgs, ... }:
let
  wallpaperPath = "~/dotfiles/wallpapers/default.webp";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;

    settings = {
      "$mainMod" = "SUPER";

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        resize_on_border = true;
      };

      exec-once = [
        # "hyprlock"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "waybar"
        "clipse -listen"
        "1password --ozone-platform=wayland --enable-features=UseOzonePlatform --slient"
      ];

      monitor = [
        "eDP-1, preferred, 0x0, 1.5" # Built-in monitor
        # "DP-2, preferred, auto-up, 1"
        "desc:Lenovo Group Limited LEN L27q-30 U161CGDL, preferred, auto-up, 1" # Old lenovo monitor at the office
        "desc:Lenovo Group Limited LEN L27q-30 U161CGC8, preferred, auto-up, 1" # Old lenovo monitor at the office
        "desc:Dell Inc. DELL S3221QS G2MHB33, preferred, auto-up, 1" # Dell at home
        " , preferred, auto-up, 1.333333" # Default for external monitors
      ];

      windowrulev2 = [
        "float,class:(clipse)"
        "size 622 652,class:(clipse)"
        "opacity:0.7,class:(clipse)"
        "size 700 500,class:(Xdg-desktop-portal-gtk),title:(Open File)"
        "center,class:(Xdg-desktop-portal-gtk),title:(Open File)"
        "size 700 500,class:(Xdg-desktop-portal-gtk),title:(All File)"
        "center,class:(Xdg-desktop-portal-gtk),title:(All File)"

        "size 700 500,class:(xdg-desktop-portal-gtk),title:(Open File)"
        "center,class:(xdg-desktop-portal-gtk),title:(Open File)"
        "size 700 500,class:(xdg-desktop-portal-gtk),title:(All File)"
        "center,class:(xdg-desktop-portal-gtk),title:(All File)"

        "size 300 200,class:(polkit-gnome-authentication-agent-1)"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      env = [
        "GDK_SCALE,1"
        "XCURSOR_SIZE,24"
        "GTK_THEME,Papirus-Dark"
      ];

      bind =
        [
          # App launcher
          "$mainMod, SPACE, exec, walker"

          # Terminal, filemanager, browser, etc.
          "$mainMod, RETURN, exec, ghostty"
          "$mainMod, Q, killactive"
          "$mainMod SHIFT, M, exit"
          "$mainMod, E, exec, nautilus --new-window"
          "$mainMod, B, exec, chromium --ozone-platform-hint=auto --enable-features=UseOzonePlatform,TouchpadOverscrollHistoryNavigation --ozone-platform=wayland --disable-session-crashed-bubble"
          "$mainMod, S, exec, slack --enable-features=UseOzonePlatform,WaylandWindowDecorations,WebRTCPipeWireCapturer --ozone-platform=wayland"

          # Lock on power button
          ", XF86PowerOff, exec, hyprlock"

          "$mainMod, Left, exec, wtype -k Home"
          "$mainMod, Right, exec, wtype -k End"

          # Screenshot utils
          # region → copy to clipboard
          "CTRL SHIFT, 4, exec, hyprshot -m region --clipboard-only"
          # region → save to /tmp, then open in Gradia
          "CTRL SHIFT, 5, exec, hyprshot -m region -o /tmp -- gradia"
          # focused window → save to /tmp, then open in Gradia
          "CTRL SHIFT, 3, exec, hyprshot -m window -o /tmp -- gradia"
          # full output → save to /tmp, then open in Gradia
          "CTRL SHIFT, 2, exec, hyprshot -m output -o /tmp -- gradia"

          # Media playback
          ",<XF86AudioPlay>,exec,playerctl play-pause"
          ",<XF86AudioNext>,exec,playerctl next"
          ",<XF86AudioPrev>,exec,playerctl previous"

          # Clipboard history
          "SUPER SHIFT, V, exec, walker -q '@'"

          # UI & Tiling
          "$mainMod, T, togglefloating"
          "$mainMod, F, fullscreen"
          "$mainMod CTRL, RETURN, exec, rofi -show drun" # TODO: change this to walker
          "$mainMod, P, exec, hyprpicker -a"
          "$mainMod SHIFT, P, pseudo"
          "$mainMod, O, togglesplit"

          # Volume & Brightness
          # Make some of those binde so that they can be held to repeat
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

          # Move workspace to another monitor
          "$mainMod SHIFT, M,  movecurrentworkspacetomonitor, +1"

          # Tab swtiching using Alt+[HL]
          "ALT, L, sendshortcut, CTRL, TAB, activewindow"
          "ALT, H, sendshortcut, CTRL_SHIFT, TAB, activewindow"
          # Moving tabs using Alt*Shift+[HL] mapped to Ctrl+Shift+page_up/down
          # TODO: this does not work
          "ALT SHIFT, L, movewindow, r"
          "ALT SHIFT, H, movewindow, l"
        ]
        ++
        # Workspaces [switch + move]
        (builtins.concatLists (
          builtins.genList
            (
              i:
              let
                ws = toString (i + 1);
                code = "code:1${toString i}";
              in
              [
                "$mainMod, ${code}, workspace, ${ws}"
                "$mainMod SHIFT, ${code}, movetoworkspace, ${ws}"
              ]
            )
            9
        ));

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      binde = [
        "$mainMod, equal,  resizeactive,  10  0"
        "$mainMod, minus, resizeactive, -10 0"
        "$mainMod shift, equal, resizeactive, 0 -10"
        "$mainMod shift, minus, resizeactive, 0 10"
      ];

      input = {
        kb_layout = "us,si";
        kb_variant = ",us";
        follow_mouse = 1;
        kb_options = "grp:alt_shift_toggle";
        touchpad = {
          clickfinger_behavior = "1";
          natural_scroll = true;
          scroll_factor = 0.3;
          drag_lock = 0;
        };
        repeat_delay = 300;
        repeat_rate = 30;
        sensitivity = 0;
        accel_profile = "flat";
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
          "layersIn, 1, 3, menu_decel, slide"
          "layersOut, 1, 1.6, menu_accel"
          "fadeLayersIn, 1, 2, menu_decel"
          "fadeLayersOut, 1, 4.5, menu_accel"
          "workspaces, 1, 7, menu_decel, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [ wallpaperPath ];
      wallpaper = [ ",${wallpaperPath}" ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock";
        before_sleep_cmd = "hyprlock";
      };
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      pam = {
        enabled = true;
      };
      fingerprint = {
        enabled = true;
      };
      auth = {
        pam = {
          enabled = true;
        };
        fingerprint = {
          enabled = true;
          ready_message = "Scan fingerprint to unlock";
          present_message = "Scanning fingerprint …";
          retry_delay = 250;
        };
      };
      general = {
        hide_cursor = true;
        immediate_render = true;
        no_fade_in = true;
        no_fade_out = true;
        ignore_empty_input = true;
      };
      background = [
        {
          blur_passes = 2;
          path = wallpaperPath;
        }
      ];
      input-field = [
        {
          check_color = "rgba(0, 0, 0, 0)";
          dots_fade_time = 0;
          fade_timeout = 0;
          fail_color = "rgba(0, 0, 0, 0)";
          fail_timeout = 0;
          fail_transition = 0;
          font_color = "rgba(255, 255, 255, 0.5)";
          inner_color = "rgba(0, 0, 0, 0)";
          outer_color = "rgba(0, 0, 0, 0)";
          fail_text = "";
          placeholder_text = "";
        }
      ];
      label = [
        {
          text = "$TIME";
          color = "rgb(255, 255, 255)";
          font_family = "FiraCode Nerd Font";
          font_size = 96;
          halign = "center";
          position = "0, 160";
          text_align = "center";
          valign = "center";
        }
      ];
    };
  };
}
