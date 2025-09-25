_: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true; # if not already enabled
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment the following
    #jack.enable = true;
  };
  services.pipewire.wireplumber = {
    enable = true;
    extraConfig.bluetoothEnhancements = {
      "monitor.bluez.properties" = {
        "bluez5.dummy-avrcp-player" = false;
      };
    };
  };
}
