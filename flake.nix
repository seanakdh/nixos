{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      tux = rec {
        hostname = "tux";
        system = "x86_64-linux";
        unstable = import nixpkgs-unstable { system = system; config.allowUnfree = true; };
        pkgs = import nixpkgs { system = system; config.allowUnfree = true; };
      };
      raspi = {

      };
    in
    {
      nixosConfigurations = {
        ${tux.hostname} = nixpkgs.lib.nixosSystem {
          system = tux.system;
          specialArgs = {
            unstable = tux.unstable;
            pkgs = tux.pkgs;
            hostname = tux.hostname;
          };
          modules = [
             ./hosts/${tux.hostname}
          ];
        };
      };
    };
}
