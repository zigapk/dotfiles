{
  pkgs,
  pkgs-unstable,
}:
with pkgs;
[
  # 🧑‍💻 Developer Tools
  vscode
  uv
  bruno
  bruno-cli
  gemini-cli-bin
  pkgs-unstable.opencode
  pkgs-unstable.claude-code
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
  anydesk
  transmission_4-gtk

  # 🎨 Creative & Multimedia
  gimp
  inkscape
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

  # ⌨️ Libraries & Firmware
  libqalculate
  qmk
  alsa-utils

  # 📦 Gnome Extensions
  gnomeExtensions.focus-changer
  gnomeExtensions.pano
  gnomeExtensions.blur-my-shell
  gnomeExtensions.wallpaper-slideshow
  gnomeExtensions.bluetooth-battery-meter

  # Languages and Frameworks
  python314
]
