{
  pkgs,
  ...
}:
# Lean system package set for the headless kibla server. Most everyday CLI /
# TUI tooling (bat, fzf, ripgrep, jq, btop, lazygit, ...) comes from the shared
# home-manager layer (home/zsh.nix); this list is only the system-level extras
# a server actually needs. herdr lives in the common role (both hosts).
with pkgs;
[
  fd
  fastfetch
  pciutils
  usbutils
  killall
  unzip
  lsof
  gnupg
  openssl
  tailscale
  magic-wormhole
]
