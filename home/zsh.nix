{ config
, pkgs
, ...
}: {
  home.packages = with pkgs; [
    bat
    fzf
    vivid
    zoxide
    atuin
    direnv
    btop
    eza
    btop
    eza
    fzf
    wget
    tree
    ripgrep
    cloc
    jq
    lazygit
    lazydocker
    neofetch
    nmap
  ];

  programs.zsh = {
    enable = true;
    history.size = 50000;
    history.path = "${config.xdg.dataHome}/zsh/history";
    shellAliases = {
      vim = "nvim";
      ctrl-l = "clear";
      C-l = "ctrl-l";
      control-l = "clear";
      clean = "clear";
      ls = "eza -lh --group-directories-first --icons";
      lsa = "ls -la";
      lt = "ls --tree --level=2 --git'";
      lta = "lt -a";
      ff = "fzf --preview 'bat --style=numbers --color=always {}'";
      wake-kibla = "ssh router \"for i in {1..10}; do wakeonlan -i 192.168.0.255 b2:b7:37:b5:43:f4; sleep 0.4; done\"";
      htop = "btop";
      top = "btop";
      cat = "bat";
      dinit = "echo \"use nix\" >> .envrc && direnv allow";
      wttr = "curl wttr.in/Ljubljana";
      weather = "curl wttr.in/Ljubljana";
      v = "nvim .";
    };
    initExtra = ''
      ZSH_DISABLE_COMPFIX=true
      export EDITOR=nvim
      export VISUAL="nvim"
      export BAT_THEME="Dracula"
      export LS_COLORS=$(vivid generate dracula)
      if [ -n "$TTY" ]; then
        export GPG_TTY=$(tty)
      else
        export GPG_TTY="$TTY"
      fi

      setopt appendhistory
      setopt sharehistory
      setopt hist_ignore_space
      setopt hist_ignore_all_dups
      setopt hist_save_no_dups
      setopt hist_ignore_dups
      setopt hist_find_no_dups

      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

      # Shell integrations
      eval "$(starship init zsh)"
      eval "$(atuin init zsh --disable-up-arrow)"
      eval "$(direnv hook zsh)"
      eval "$(fzf --zsh)"
      eval "$(zoxide init --cmd cd zsh)"

    '';
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "docker"
        "golang"
        "kubectl"
        "kubectx"
        "rust"
        "command-not-found"
        "pass"
        "helm"
      ];
    };
    plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
      {
        name = "zsh-completions";
        src = pkgs.zsh-completions;
        file = "share/zsh-completions/zsh-completions.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      }
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
    ];
  };
}
