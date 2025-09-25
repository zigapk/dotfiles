{ pkgs }:
let
  codex = pkgs.callPackage ./codex.nix { };
in
with pkgs;
[
  # TODO: move some (most) of this into home manager packages
  iw
  fd
  uv
  gnupg
  qmk
  fastfetch
  pciutils
  gemini-cli-bin
  tuigreet
  clipse
  wl-clipboard
  wtype
  unzip
  codex
  sleuthkit
  dysk
  slack
  magic-wormhole
  firefox
  caprine
  signal-desktop
  vscode
  vlc
  file-roller
  transmission_4-gtk
  nautilus
  gimp
  loupe
  tailscale
  # hyprpolkitagent
  polkit_gnome
  qt5.qtwayland
  qt6.qtwayland
  brightnessctl
  figma-linux
  chromium
  gradia
  hyprshot
  hyprpicker
  libqalculate
  imagemagick
  poppler-utils
  anydesk
  opencode
  killall
  overskride
  playerctl
  bruno
  bruno-cli
  openssl
  xdg-desktop-portal-hyprland
  xdg-desktop-portal-gtk
  gnome-disk-utility
  gparted
  superfile

  # Things required for QMK
  avrdude
  dfu-programmer
  dfu-util
  hidapi
]
