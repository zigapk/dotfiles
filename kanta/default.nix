{ pkgs, lib, ... }:
{
  # --- Touchpad / libinput ---
  # Tuned for a macOS-like feel on the Framework 13 trackpad.
  services.libinput = {
    enable = true;
    touchpad = {
      accelProfile = "adaptive";
      accelSpeed = "0.0";
      naturalScrolling = true;
      tapping = true;
      tappingDragLock = true;
      disableWhileTyping = true;
      clickMethod = "clickfinger"; # 2-finger = right click, 3-finger = middle (macOS style)
    };
    mouse = {
      accelProfile = "adaptive";
      accelSpeed = "0.0";
    };
  };

  # --- Palm rejection quirks ---
  # Force libinput to recognize the Framework keyboard and touchpad as internal
  # devices so that Disable-While-Typing (DWT) works correctly.
  # Without this, libinput may treat them as separate external devices and skip
  # palm rejection entirely.
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Framework Keyboard]
    MatchUdevType=keyboard
    MatchName=AT Translated Set 2 keyboard
    AttrKeyboardIntegration=internal

    [Framework Touchpad]
    MatchUdevType=touchpad
    MatchName=PIXA3854:00 093A:0274 Touchpad
    AttrKeyboardIntegration=internal
  '';

  # --- Speaker audio enhancement (from nixos-hardware) ---
  # Applies psychoacoustic bass enhancement, loudness compensation, EQ, and
  # compression via PipeWire DSP. Set raw speaker volume to 100% before enabling,
  # as the DSP chain handles volume itself.
  hardware.framework.laptop13.audioEnhancement.enable = true;

  # --- Fingerprint reader ---
  # The nixos-hardware module enables fprintd by default, but we also need the
  # Goodix TOD driver for the Framework 13's specific fingerprint sensor.
  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;

  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };
}
