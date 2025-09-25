{ pkgs, ... }:
# https://wiki.archlinux.org/title/Wayland#Electron
let
  electronFlags = pkgs.writeText "electron-flags.conf" ''
    --enable-features=UseOzonePlatform
    --ozone-platform=wayland
  '';
in
{
  xdg.configFile = {
    "electron-flags.conf".source = electronFlags;
    "electron18-flags.conf".source = electronFlags;
    "electron17-flags.conf".source = electronFlags;
    "electron16-flags.conf".source = electronFlags;
    "code-flags.conf".source = electronFlags;
    "codium-flags.conf".source = electronFlags;
  };

  # https://github.com/microsoft/vscode/issues/109176
  home.file.".local/bin/code" = {
    text = ''
      #!/usr/bin/env bash
      codium --ozone-platform=wayland $@
    '';
    executable = true;
  };
}
