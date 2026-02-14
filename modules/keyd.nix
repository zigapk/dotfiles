_: {
  services.keyd = {
    enable = true;

    keyboards = {
      default = {
        # Apply to all keyboards
        ids = ["*"];

        settings = {
          main = {
            # Maps CapsLock → Esc when tapped, Ctrl when held
            capslock = "overload(control, esc)";
          };

          # This new section defines the 'alt' layer
          alt = {
            # Maps alt+h to ctrl+shift+tab
            h = "C-S-tab";
            l = "C-tab";
            c = "C-c";
            v = "C-v";
            x = "C-x";
          };

          meta = {
            tab = "A-tab";
          };
        };
      };
    };
  };
}
