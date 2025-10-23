{ pkgs }:
with pkgs; [
  # 🧑‍💻 Developer Tools
  vscode
  uv
  bruno
  bruno-cli
  gemini-cli-bin
  claude-code
  opencode
  rpi-imager

  # 🌐 Web & Communication
  firefox
  chromium
  google-chrome
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
  pandoc
  librsvg
  texliveFull
  obsidian

  # ⚙️ Core CLI Utilities
  fd
  fastfetch
  dysk
  superfile
  pciutils
  killall
  unzip
  poppler-utils
  lsof
  fast-cli

  # 🛠️ System & Disk Management
  gparted
  dconf

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
  alsa-utils

  # 📦 Gnome Extensions
  gnomeExtensions.focus-changer
  gnomeExtensions.pano
  gnomeExtensions.blur-my-shell
  gnomeExtensions.wallpaper-slideshow

  # Languages and Frameworks
  python314
]
