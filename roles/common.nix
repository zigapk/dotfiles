{
  pkgs,
  inputs,
  username,
  homeDirectory,
  emoji,
  home-manager,
  nixvim,
  ...
}:
let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    config.allowUnfree = true;
  };
in
{
  imports = [
    home-manager.nixosModules.home-manager
    ../modules/nix.nix
    ../modules/boot.nix
    ../modules/networking.nix
    ../modules/users.nix
    ../modules/locale.nix
    ../modules/virtualisation.nix
  ];

  # Expose the unstable pkgs set to sibling NixOS modules (e.g. desktop role).
  _module.args.pkgs-unstable = pkgs-unstable;

  # herdr runs on every host: directly on kanta, or on kibla via `--remote`.
  environment.systemPackages = [
    inputs.herdr.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit
        inputs
        username
        homeDirectory
        emoji
        pkgs-unstable
        ;
    };
    sharedModules = [ nixvim.homeModules.nixvim ];
    users.${username}.imports = [ ../home/common.nix ];
  };

  system.stateVersion = "26.05";
}
