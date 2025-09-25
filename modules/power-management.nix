{ pkgs, ... }: {
  powerManagement.enable = true;

  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitchDocked = "ignore";
  };

  powerManagement.powertop.enable = true;

  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;
  services.tlp.settings = {
    # CPU governors
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    # USB autosuspend
    USB_AUTOSUSPEND = "1";
    # SATA link power mgmt
    SATA_LINKPWR_ON_AC = "max_performance";
    SATA_LINKPWR_ON_BAT = "min_power";
  };
}
