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

TODO:

- crush
- nur
- more wallpapers
- nix search
- make sure docker is not running by default!
- notifications focus mode
- stylish polkit agent
- flash.nvim
- low battery notification
- alt + tab moving between tabs
- test gnome + tiling extension
- test cosmic desktop beta
