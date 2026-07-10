{
  description = "Nix flake for managing all my machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    herdr = {
      url = "github:ogulcancelik/herdr/v0.7.1";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    llm-agents.url = "github:numtide/llm-agents.nix";
    pi-rewind = {
      url = "github:arpagon/pi-rewind";
      flake = false;
    };
    zerodays-agents = {
      url = "git+ssh://git@github.com/zerodays/agents";
      flake = false;
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
        buildInputs = [ pkgs.nixd ];
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
          ./kanta/default.nix
          ./roles/common.nix
          ./roles/desktop.nix
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
          inputs.nixos-hardware.nixosModules.common-cpu-amd
          inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
          inputs.nixos-hardware.nixosModules.common-pc-ssd
          ./kibla/hardware-configuration.nix
          ./roles/common.nix
          ./roles/server.nix
        ];
      };
    };
}
