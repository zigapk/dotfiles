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

TODO:
- alt + h/l inside neovim
