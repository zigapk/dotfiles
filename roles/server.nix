{
  pkgs,
  ...
}:
{
  # Headless server: no GUI, no desktop modules. Lean system package set;
  # everyday CLI/TUI tooling comes from the shared home-manager layer.
  environment.systemPackages = import ../modules/packages-server.nix {
    inherit pkgs;
  };

  # Commit signing uses the 1Password agent forwarded over SSH from kanta.
  home-manager.extraSpecialArgs.signer = "agent";
}
