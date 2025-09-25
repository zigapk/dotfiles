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

- rewrite config
- crush
- nur
- logi options+
- midnight commnader
- home row mods
- corne
- zen to nix
- copy with mod
- clipse transparency & preview
- yazi open with
- (yazi) default open apps
- night mode
- more wallpapers
- nix search
- waybar displaying docker if running
- make sure docker is not running by default!
- notifications focus mode
- stylish polkit agent
- space + hjkl to arrows
- command not found
- flash.nvim
- icons everywhere (nautilus, walker)
- low battery notification
- nvim leader+sg open that line
- alt + tab moving between tabs
- nwg-look (fonts)
