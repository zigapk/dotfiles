{
  description = "Nix flake for managing all my machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixvim,
      flake-utils,
      nix-index-database,
      nixos-hardware,
      ...
    }@inputs:
    let
      username = "zigapk";
    in
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        nativeBuildInputs = with pkgs; [ ];
        buildInputs = [ ];
      in
      {
        devShells.default = pkgs.mkShell {
          inherit buildInputs nativeBuildInputs;
        };
      }
    )
    // {
      nixosConfigurations.kanta = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          homeDirectory = "/home/${username}";
          hostname = "kanta";
          emoji = "🐋";
          inherit
            inputs
            username
            home-manager
            nixvim
            nix-index-database
            ;
        };
        modules = [
          nixos-hardware.nixosModules.framework-amd-ai-300-series
          ./kanta/hardware-configuration.nix
          ./configuration.nix
        ];
      };

      nixosConfigurations.kibla = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          homeDirectory = "/home/${username}";
          hostname = "kibla";
          emoji = "🦖";
          inherit
            inputs
            username
            home-manager
            nixvim
            nix-index-database
            ;
        };
        modules = [
          ./kibla/hardware-configuration.nix
          ./configuration.nix
        ];
      };
    };
}
