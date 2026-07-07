{
  pkgs,
  pkgs-unstable,
  herdr,
}:
with pkgs;
[
  # 🧑‍💻 Developer Tools
  vscode
  uv
  bruno
  bruno-cli
  gemini-cli-bin
  pkgs-unstable.anydesk
  pkgs-unstable.claude-code
  herdr
  saleae-logic-2
  awscli2
  android-studio
  rpi-imager

  # 🌐 Web & Communication
  firefox
  (chromium.override {
    commandLineArgs = [
      "--enable-features=AcceleratedVideoEncoder"
      "--ignore-gpu-blocklist"
      "--enable-zero-copy"
      "--ozone-platform-hint=auto"
      "--enable-features=UseOzonePlatform,TouchpadOverscrollHistoryNavigation"
      "--ozone-platform=wayland"
    ];
    enableWideVine = true;
  })
  google-chrome
  slack
  transmission_4-gtk

  # 🎨 Creative & Multimedia
  gimp
  inkscape
  loupe
  vlc
  gradia
  imagemagick
  ghostscript
  playerctl
  pandoc
  librsvg
  texliveFull
  obsidian
  libreoffice

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
  ffmpeg
  arduino-ide
  arduino-cli
  usbutils

  # 🛠️ System & Disk Management
  gparted
  dconf
  quickemu
  swtpm

  # 🔒 Security & Networking
  gnupg
  openssl
  sleuthkit
  tailscale
  iw
  magic-wormhole
  strongswan # `ipsec` CLI for controlling VPNs

  # ⌨️ Libraries & Firmware
  libqalculate
  qmk
  alsa-utils

  # 📦 Gnome Extensions
  gnomeExtensions.focus-changer
  gnomeExtensions.clipboard-indicator
  gnomeExtensions.blur-my-shell
  gnomeExtensions.wallpaper-slideshow
  gnomeExtensions.bluetooth-battery-meter

  # Languages and Frameworks
  python314
]
