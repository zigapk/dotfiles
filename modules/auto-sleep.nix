_: {
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchDocked = "ignore";
  };

  # TODO: lock on suspend
}
