# Nix config and all the other dot files

First, clone the repo:

```bash
git clone https://github.com/zigapk/dotfiles.git
```

To apply this configuration on NixOS, run:

```bash
nixos-rebuild switch --flake ~/dotfiles/nix
```

Then to update the configuration, run:

```bash
nix flake update --flake ~/dotfiles/nix/.
```

Host-specific modules that are not safe to publish (e.g. VPN config)
live in `/etc/nixos/local/` and are loaded conditionally from
`configuration.nix`. See `/etc/nixos/local/README.md` on the host for
setup instructions.

## TPM2 Auto-Decryption

To automatically decrypt your LUKS partition on boot using your motherboard's TPM 2.0 chip (bypassing the manual boot password prompt while keeping the disk securely encrypted):

```bash
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/nvme0n1p2
```

TODO:
- alt + h/l inside neovim
