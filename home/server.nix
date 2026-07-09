{ lib, ... }:
{
  # Stable SSH agent socket for a headless server reached over forwarded agent
  # (e.g. kibla via `herdr --remote` or ssh from kanta).
  #
  # Problem: every SSH connection forwards a NEW agent socket, but a long-lived
  # herdr server daemonizes with the FIRST connection's socket in its env and
  # hands that (soon-dead) path to every pane it spawns. Panes then fail with
  # "agent refused operation" / "Permission denied" — no 1Password dialog,
  # because the request dies at the dead socket before reaching the agent.
  #
  # Fix: `~/.ssh/rc` runs on every incoming SSH session (before the shell) and
  # repoints a stable symlink at that session's fresh $SSH_AUTH_SOCK. Shells
  # export the stable path, so on reconnect existing panes follow the symlink
  # to the live agent with no restart.
  home.file.".ssh/rc".text = ''
    if [ -n "$SSH_AUTH_SOCK" ] && [ "$SSH_AUTH_SOCK" != "$HOME/.ssh/agent.sock" ]; then
      ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/agent.sock"
    fi
  '';

  programs.zsh.initContent = lib.mkAfter ''
    # Use the stable forwarded-agent symlink maintained by ~/.ssh/rc so panes
    # always reach the current SSH connection's agent (see home/server.nix).
    if [ -L "$HOME/.ssh/agent.sock" ]; then
      export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
    fi
  '';
}
