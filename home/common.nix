{
  pkgs,
  pkgs-unstable,
  username,
  homeDirectory,
  emoji,
  lib,
  inputs,
  signer,
  ...
}:
{
  home = {
    inherit username;
    inherit homeDirectory;

    packages = [
      pkgs.diffnav
      inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.omp
    ];

    # pi-rewind extension for omp (git-based /rewind checkpoints).
    # omp merges `extensions` from settings.json with its own config.yml,
    # so this stays declarative without clobbering omp-managed config.yml.
    file.".omp/agent/settings.json".text = builtins.toJSON {
      extensions = [ "${inputs.pi-rewind}/src/index.ts" ];
    };

    # Slack MCP server (read-only). Long-lived xoxp user token (rotation off) read
    # from 1Password at request time; the "Bearer " prefix is added here.
    file.".omp/agent/mcp.json".text = builtins.toJSON {
      "$schema" =
        "https://raw.githubusercontent.com/can1357/oh-my-pi/main/packages/coding-agent/src/config/mcp-schema.json";
      mcpServers.slack = {
        type = "http";
        url = "https://mcp.slack.com/mcp";
        headers.Authorization =
          "!printf 'Bearer %s' \"$(op read 'op://Employee/Slack MCP App/USER_TOKEN' --account zerodays.1password.com)\"";
      };
      mcpServers.axiom = {
        type = "http";
        url = "https://mcp.axiom.co/mcp";
      };
      mcpServers.agentmail = {
        type = "http";
        url = "https://mcp.agentmail.to/mcp";
        headers."x-api-key" =
          "!op read 'op://Private/AgentMail/password' --account zerodays.1password.com";
      };
      mcpServers.posthog = {
        type = "http";
        url = "https://mcp.posthog.com/mcp";
      };
      mcpServers.figma = {
        type = "http";
        url = "https://mcp.figma.com/mcp";
      };
    };

    # Global agent instructions: upstream base from zerodays/agents (CLAUDE.md, the
    # concrete file AGENTS.md symlinks to) plus a local overlay tracked in this repo.
    # Edit agents-local.md and rebuild to tweak; `nix flake update zerodays-agents`
    # pulls upstream changes.
    file.".omp/agent/AGENTS.md".text =
      builtins.readFile "${inputs.zerodays-agents}/CLAUDE.md"
      + "\n\n"
      + builtins.readFile ./agents-local.md;

    # Skill bundled with zerodays/agents (already in omp's SKILL.md format).
    file.".omp/agent/skills/web-animation-design".source =
      "${inputs.zerodays-agents}/skills/web-animation-design";

    stateVersion = "26.05";
  };

  # herdr keybindings: prefix+ctrl+{h,l} = prev/next tab, prefix+ctrl+{j,k} =
  # next/prev workspace (vim-style: horizontal=tabs, vertical=workspaces).
  # onboarding=false suppresses first-run setup, herdr's only write-back path,
  # so the store symlink stays valid. `herdr server reload-config` to apply.
  xdg.configFile."herdr/config.toml".text = ''
    onboarding = false

    [keys]
    previous_tab = "prefix+ctrl+h"
    next_workspace = "prefix+ctrl+j"
    previous_workspace = "prefix+ctrl+k"
    next_tab = "prefix+ctrl+l"
  '';

  imports = [
    ./zsh.nix
  ];

  programs = {
    home-manager.enable = true;

    git = import ./git.nix { inherit pkgs lib signer; };
    starship = import ./starship.nix { inherit emoji; };
    atuin = import ./atuin.nix { inherit pkgs; };
    zoxide = import ./zoxide.nix { inherit pkgs; };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    nixvim = import ./nixvim.nix { inherit pkgs lib; };

    # Base ssh client. No IdentityAgent here: on the headless server this lets
    # the 1Password agent forwarded over SSH from kanta ($SSH_AUTH_SOCK) drive
    # auth and commit signing. The desktop layer adds the local agent socket.
    ssh = {
      enable = true;
      enableDefaultConfig = false;
    };

    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };

    opencode = {
      enable = true;
      package = pkgs-unstable.opencode;
      settings = {
        plugin = [ "opencode-claude-auth@latest" ];
        agent = {
          build = {
            enable1mContext = true;
          };
        };
      };
    };
  };
}
