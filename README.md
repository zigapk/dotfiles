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

- STICKY KEYS
- remove SUPER to reveal search
- wallpaper(s)
- alt + h/l inside neovim
- tlp switcher
- nix search
- make sure docker is not running by default!
- flash.nvim
