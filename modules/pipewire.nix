_: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.pipewire.wireplumber = {
    enable = true;
    extraConfig.bluetoothEnhancements = {
      "monitor.bluez.properties" = {
        "bluez5.dummy-avrcp-player" = false;
      };
    };
    extraConfig.no-ucm = {
      "monitor.alsa.properties" = {
        "alsa.use-ucm" = false;
      };
    };
  };
}
