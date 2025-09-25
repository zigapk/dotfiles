_: {
  services.keyd = {
    enable = true;

    keyboards = {
      default = {
        # Apply to all keyboards
        ids = [ "*" ];

        settings = {
          main = {
            # Maps CapsLock → Esc when tapped, Ctrl when held
            capslock = "overload(control, esc)";

            # Remaps the Escape key to CapsLock
            # esc = "capslock";
          };
        };

        # no extraConfig needed for this simple setup
        extraConfig = "";
      };
    };
  };
}
