# Nix config and all the other dot files

## Usage

1. Install nix by running `sh <(curl -L https://nixos.org/nix/install)`.
2. Clone this repo into `~/dotfiles`.
3. Possibly change the brew from existing installation to a new one [docs here](https://github.com/zhaofengli/nix-homebrew?tab=readme-ov-file#a-new-installation).
4. Each time you want to switch to the new configuration, run:

```bash
darwin-rebuild switch --flake ~/dotfiles/nix
```

5. Restore some configurations that cannot be automated:
   - Raycast: Import `Raycast [TIME].rayconfig` (encryption password is saved in 1password).
   - Rectangle: Import the preferences from `RectangleConfig.json`.
6. Reboot for some changes to take effect (input sources, etc.).
7. Install Docker (Desktop) - at the time of writing, Docker is not supported on Nix Darwin.

Then to update the configuration, run:

```bash
nix flake update --flake ~/dotfiles/nix/.
```

TODO:

- logi options+
- midnight commnader
- home row mods
- corne
- zen to nix
