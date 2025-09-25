{ pkgs }:
with pkgs; [
  # 🧑‍💻 Developer Tools
  vscode
  uv
  bruno
  bruno-cli
  gemini-cli-bin

  # 🌐 Web & Communication
  firefox
  chromium
  slack
  anydesk
  transmission_4-gtk

  # 🎨 Creative & Multimedia
  gimp
  loupe
  vlc
  figma-linux
  gradia
  imagemagick
  playerctl

  # ⚙️ Core CLI Utilities
  fd
  fastfetch
  dysk
  superfile
  pciutils
  killall
  unzip
  poppler-utils

  # 🖥️ Hyprland & Wayland Integration
  xdg-desktop-portal-hyprland
  hyprshot
  hyprpicker
  wl-clipboard
  wtype
  clipse
  qt5.qtwayland
  qt6.qtwayland

  # 🛠️ System & Disk Management
  nautilus
  file-roller
  gnome-disk-utility
  gparted
  overskride
  brightnessctl
  polkit_gnome
  tuigreet

  # 🔒 Security & Networking
  gnupg
  openssl
  sleuthkit
  tailscale
  iw
  magic-wormhole

  # ⌨️ Libraries & Firmware
  libqalculate
  qmk
]
