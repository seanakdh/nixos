{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      allowUnfree = true;
      tux = rec {
        system = "x86_64-linux";
        specialArgs = {
          hostname = "tux";
          unstable = import nixpkgs-unstable {
            system = system;
            config.allowUnfree = allowUnfree;
          };
          pkgs = import nixpkgs {
            system = system;
            config.allowUnfree = allowUnfree;
          };
        };
        modules = [ ./hosts/${specialArgs.hostname} ];
      };
    in {

      nixosConfigurations = {
        ${tux.specialArgs.hostname} =
          nixpkgs.lib.nixosSystem { inherit (tux) system specialArgs modules; };
      };
    };
}
