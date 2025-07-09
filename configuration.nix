{ config
, pkgs
, hostname
, nixvim
, username
, homeDirectory
, home-manager
, emoji
, zen-browser
, ...
}: {
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Ljubljana";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sl_SI.UTF-8";
    LC_IDENTIFICATION = "sl_SI.UTF-8";
    LC_MEASUREMENT = "sl_SI.UTF-8";
    LC_MONETARY = "sl_SI.UTF-8";
    LC_NAME = "sl_SI.UTF-8";
    LC_NUMERIC = "sl_SI.UTF-8";
    LC_PAPER = "sl_SI.UTF-8";
    LC_TELEPHONE = "sl_SI.UTF-8";
    LC_TIME = "sl_SI.UTF-8";
  };

  imports = [
    # Home manager modules
    home-manager.nixosModules.home-manager
    ./modules/kanata
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [
      nixvim.homeManagerModules.nixvim
    ];
    users.zigapk = import ./home/home.nix {
      inherit emoji username homeDirectory config pkgs;
    };
  };

  # Set zsh a default for all users
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Use UWSM as session manager
  programs.uwsm.enable = true;
  programs.uwsm.waylandCompositors = {
    #   hyprland = {
    #     prettyName = "Hyprland";
    #     comment = "Hyprland compositor manager by UWSM";
    #     binPath = "/etc/profiles/per-user/${username}/bin/hyprland";
    #   };
  };
  services.xserver.desktopManager.runXdgAutostartIfNone = true;
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.hyprland.withUWSM = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-media-tags-plugin
      thunar-volman
    ];
  };
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  environment.enableAllTerminfo = true;

  # Enable greetd
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "tuigreet --cmd \"uwsm start default\"";
      };
    };
  };

  # Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };

  # Enable sudo without password
  security.sudo.wheelNeedsPassword = false;

  # Define a user account
  users.users.zigapk = {
    isNormalUser = true;
    description = "Žiga Patačko Koderman";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ bluetui firefox ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    iw
    pciutils
    greetd.tuigreet
    autopsy
    perl
    unzip
    sleuthkit
    dysk
    zen-browser.packages."x86_64-linux".default
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  system.stateVersion = "25.05";

  # Picerija
  services.caddy = {
    enable = true;
    virtualHosts."pica.ziga.pk".extraConfig = ''
      reverse_proxy localhost:8765
    '';
  };
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];

  #   systemd.services.pica = {
  #     enable = true;
  #     description = "Pica";
  #     after = [ "network.target" ];
  #     wantedBy = [ "multi-user.target" ];
  #
  #     serviceConfig = {
  #       ExecStart = "/bin/sh -c \"cd /home/zigapk/twilio-picerija/ && /run/current-system/sw/bin/nix develop --command python3 server.py\"";
  #       Restart = "always";
  #       RestartSec = 5;
  #       StandardOutput = "journal";
  #       StandardError = "journal";
  #       User = "zigapk"; # Uncomment if you want it under a specific user
  #     };
  #   };
}
