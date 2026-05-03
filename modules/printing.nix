{ pkgs, ... }:
{
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      samsung-unified-linux-driver
      splix
      gutenprint
      gutenprintBin
    ];
  };

  # Network printer discovery (harmless for USB; useful if shared over network).
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # USB printer hotplug / permissions for Samsung/Xerox ULD devices.
  services.udev.packages = [ pkgs.samsung-unified-linux-driver ];

  # Backend for GNOME Settings > Printers (needed for the GUI to add printers).
  programs.system-config-printer.enable = true;
}
