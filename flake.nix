{
  description = "Nix flake for managing all my machines (darwin & linux)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nix-darwin
    , nixpkgs
    , home-manager
    , nix-homebrew
    , nixvim
    , zen-browser
    , flake-utils
    , ...
    } @ inputs:
    let
      username = "zigapk";
    in
    flake-utils.lib.eachDefaultSystem
      (
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
      darwinConfigurations."unicorn" = nix-darwin.lib.darwinSystem {
        specialArgs = {
          homeDirectory = "/Users/${username}";
          inherit inputs username home-manager nix-homebrew nixvim;
        };
        modules = [
          ./darwin/configuration.nix
        ];
      };

      nixosConfigurations.kibla = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          homeDirectory = "/home/${username}";
          hostname = "kibla";
          emoji = "🦖";
          inherit inputs username home-manager nixvim zen-browser;
        };
        modules = [
          ./kibla/hardware-configuration.nix
          ./configuration.nix
        ];
      };
    };
}
