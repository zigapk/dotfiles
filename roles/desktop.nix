{
  pkgs,
  pkgs-unstable,
  lib,
  username,
  ...
}:
{
  imports = [
    ../modules/gnome.nix
    ../modules/fonts.nix
    ../modules/keyd.nix
    ../modules/pipewire.nix
    ../modules/uinput.nix
    ../modules/printing.nix
  ]
  # Optional out-of-tree modules (host-specific, not in git).
  # Anvina VPN config lives in /etc/nixos/local/anvina.nix because it
  # contains gateway IP, EAP username and internal subnet that we don't
  # want in a public repo. See README for setup instructions.
  ++ lib.optional (builtins.pathExists /etc/nixos/local/anvina.nix) /etc/nixos/local/anvina.nix;

  hardware.graphics.enable = true;

  # Plymouth boot animation (BGRT theme reuses BIOS Framework OEM logo with a spinner)
  boot.plymouth = {
    enable = true;
    theme = "bgrt";
  };
  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];

  xdg.icons.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  hardware.keyboard.qmk.enable = true;

  # Saleae Logic 2 support
  hardware.saleae-logic.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ username ];
  };

  # Allow for USB passthrough to quickemu (quemu) virtual machines based on USB IDs
  virtualisation.spiceUSBRedirection.enable = true;
  services.udev.extraRules = ''
    # Teknic ClearCore USB Passthrough Permissions
    SUBSYSTEM=="usb", ATTR{idVendor}=="2890", ATTR{idProduct}=="8022", MODE="0666", GROUP="users"
    SUBSYSTEM=="usb", ATTR{idVendor}=="2890", ATTR{idProduct}=="0201", MODE="0666", GROUP="users"
  '';

  # Installs Saleae Logic 2 udev rules for USB device access without root.
  services.udev.packages = [ pkgs.saleae-logic-2 ];

  services.upower.enable = true;
  services.dbus.enable = true;

  # Ollama
  services.ollama = {
    enable = true;
    package = pkgs-unstable.ollama-vulkan;
  };

  environment.systemPackages = import ../modules/packages-desktop.nix {
    inherit pkgs pkgs-unstable;
  };

  # Commit signing uses the local 1Password app (op-ssh-sign).
  home-manager.extraSpecialArgs.signer = "op";
  home-manager.users.${username}.imports = [ ../home/desktop.nix ];
}
