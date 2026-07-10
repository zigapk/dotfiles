# Nix config and all the other dot files

Flake managing two machines:

- **kanta** — Framework 13 AMD laptop; GNOME desktop workstation.
- **kibla** — ASUS Ryzen desktop; headless server (no GUI), reached over Tailscale.

## Structure

```
flake.nix                 # per-host module lists (hostname → config)
roles/
  common.nix              # shared base: imports modules/ + home-manager (home/common.nix)
  desktop.nix             # kanta only: GUI modules, 1Password GUI, desktop packages, home/desktop.nix
  server.nix              # kibla only: lean packages, forwarded-agent socket, home/server.nix
modules/                  # single-purpose system modules
  networking.nix          #   network-critical anchor: hostname, NM, resolved, tailscale, sshd, firewall
  nix.nix boot.nix users.nix locale.nix virtualisation.nix
  secrets.nix             #   agenix wiring (both hosts)
  gnome.nix pipewire.nix printing.nix fonts.nix keyd.nix uinput.nix   # desktop role
  packages-desktop.nix packages-server.nix
home/
  common.nix              # shared home-manager (zsh, nvim, starship, git, gh, opencode, omp, mcp.json)
  desktop.nix server.nix  # per-role home layers
  git.nix                 # parametric `signer`: "op" (kanta) | "agent" (kibla)
  zsh.nix nixvim.nix starship.nix ...
kanta/ kibla/             # per-host hardware-configuration.nix + nixos-hardware profile
secrets/                  # agenix: *.age ciphertext + secrets.nix recipient list
```

## Applying

`switch` (alias for `sudo nixos-rebuild --flake ~/dotfiles --impure switch`) picks the
config matching the machine's hostname automatically.

- **kanta:** `switch`
- **kibla:** `cd ~/dotfiles && git pull && switch` (the alias does not pull)

Update inputs: `nix flake update` (or a single input: `nix flake update <name>`).

Host-specific modules not safe to publish (e.g. Anvina VPN) live in
`/etc/nixos/local/` and are loaded conditionally from `roles/desktop.nix`.

## Secrets (agenix)

MCP tokens (Slack, AgentMail) are stored as age ciphertext in `secrets/`, encrypted
to **both** hosts' `ssh_host_ed25519_key`, and decrypted at activation to
`/run/agenix/<name>` (tmpfs, `0400`, owned by the user). `home/common.nix`'s
`mcp.json` reads them with `!cat`, so there is no 1Password CLI dependency — this
works on the headless server. (PostHog/Figma MCP use their own OAuth flows, no secret.)

Rotate a secret (recipient keys are in `secrets/secrets.nix`):

```bash
op read 'op://Employee/Slack MCP App/USER_TOKEN' | tr -d '\n' | \
  nix run nixpkgs#age -- \
    -r "<kanta-hostkey>" -r "<kibla-hostkey>" -o secrets/slack-token.age
git commit -am "rotate slack token" && switch
```

Add a new secret: add the `.age` to `secrets/secrets.nix`, declare it in
`modules/secrets.nix` (`age.secrets.<name>`), reference `/run/agenix/<name>`.

## Commit signing & SSH

- **kanta** signs via the 1Password GUI agent (`op-ssh-sign`); `IdentityAgent` →
  `~/.1password/agent.sock`. It forwards the agent to kibla (`Host kibla ForwardAgent`).
- **kibla** has no local agent: it uses the agent forwarded over SSH from kanta, so
  commit signing / auth prompts appear **on kanta** and fail closed without approval.
  `~/.ssh/rc` repoints a stable `~/.ssh/agent.sock` at each connection's forwarded
  socket so long-lived herdr panes always reach the live agent (no stale-socket
  failures, no restart needed after reconnect).

## herdr / omp clipboard on GNOME

GNOME/Mutter exposes no clipboard data-control protocol, so `wl-paste` hangs. On
kanta, `herdr` and `omp` are aliased to run with `WAYLAND_DISPLAY` unset, forcing the
working XWayland (`xclip`) path; `wl-clipboard` + `xclip` are installed for them to
call. For remote image paste, launch `herdr --remote kibla` from kanta (the client
grabs the local clipboard). nvim on headless hosts uses an OSC 52 clipboard provider
(set in `home/nixvim.nix`) so yank/paste ride the terminal back to the attaching
client.

## TPM2 Auto-Decryption

To automatically decrypt a LUKS partition on boot using the motherboard's TPM 2.0
chip (bypassing the manual boot password prompt while keeping the disk encrypted):

```bash
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/nvme0n1p2
```

TODO:
- alt + h/l inside neovim
