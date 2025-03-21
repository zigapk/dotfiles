{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nix-darwin
    , nixpkgs
    , home-manager
    , nix-homebrew
    , nixvim
    , ...
    } @ inputs:
    let
      username = "zigapk";
    in
    {
      # Unicorne (my M1 MacBook Pro)
      darwinConfigurations."unicorn" = nix-darwin.lib.darwinSystem {
        specialArgs = {
          homeDirectory = "/Users/${username}";
          inherit inputs username home-manager nix-homebrew nixvim;
        };
        modules = [
          ./darwin/configuration.nix
        ];
      };

      nixosConfigurations = {
        kibla = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
          ];
        };
      };
    };
}
