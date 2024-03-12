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
      tux = {
        hostname = "tux";
        system = "x86_64-linux";
      };

    in
    {
      nixosConfigurations = {
        ${tux.hostname} = nixpkgs.lib.nixosSystem {
          system = tux.system;
          specialArgs = {
            unstable = nixpkgs-unstable.legacyPackages.${tux.system};
            hostname = tux.hostname;
          };
          modules =  [
             ./hosts/${tux.hostname}
          ];
        };
      };
    };
}
