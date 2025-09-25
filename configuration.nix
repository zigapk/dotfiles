{ config
, pkgs
, lib
, hostname
, nixvim
, username
, homeDirectory
, home-manager
, emoji
, zen-browser
, walker
, ...
}: {
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableAllFirmware = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  # Dynamicall linked executables support
  programs.nix-ld.enable = true;
  # Set your time zone.
  time.timeZone = "Europe/Ljubljana";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  xdg.icons.enable = true;

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
    ./modules/pipewire.nix
    ./modules/auto-sleep.nix
    ./modules/power-management.nix
    ./modules/fonts.nix
    ./modules/keyd.nix
    ./modules/printers.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [
      nixvim.homeModules.nixvim
      walker.homeManagerModules.default
    ];
    users.zigapk = import ./home/home.nix {
      inherit
        lib
        emoji
        username
        homeDirectory
        config
        pkgs
        walker
        ;
    };
  };

  # Set zsh a default for all users
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Use UWSM as session manager
  programs.uwsm.enable = true;
  services.xserver.desktopManager.runXdgAutostartIfNone = true;
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.hyprland.withUWSM = true;

  services.gvfs.enable = true;
  services.tumbler.enable = true;

  environment.enableAllTerminfo = true;
  hardware.keyboard.qmk.enable = true;

  # Enable greetd
  services.greetd = {
    enable = true;
    settings = {
      # default_session = {
      #   command = "tuigreet --cmd \"uwsm start default\"";
      # };
      default_session = {
        user = username;
        command = "uwsm start default";
      };
    };
  };

  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };
  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;

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
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "65536";
    }
    {
      domain = "*";
      type = "hard";
      item = "nofile";
      value = "1048576";
    }
  ];

  # Define a user account
  users.users.zigapk = {
    isNormalUser = true;
    description = "Žiga Patačko Koderman";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG5r1Mt9pLlX7cA8F6ZVZSkrP/k9sPVSrSbeNSnyumrY"
    ];
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = import ./modules/packages.nix { inherit pkgs zen-browser; };

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ username ];
  };

  programs.nix-index = {
    enable = true;
    enableZshIntegration = false;
    enableBashIntegration = false;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  services.tailscale.enable = true;
  system.stateVersion = "25.05";

  services.upower.enable = true;
  services.dbus.enable = true;

  # Install docker but don't run it by default
  virtualisation.docker.enable = true;
  systemd.services."docker.service".enable = false;

  security.pam.services.hyprlock = {
    enable = true;
    fprintAuth = true;
  };

  networking.firewall.allowedTCPPorts = [
    22
    80
    443
  ];
}
