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
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      unstable = nixpkgs-unstable.legacyPackages.${system};
      tux-laptop = "tux";
    in
    {
      nixosConfigurations = {
        ${tux-laptop} = nixpkgs.lib.nixosSystem {

          specialArgs = {inherit inputs unstable;};
          modules = [ 
            ./hosts/${tux-laptop}/configuration.nix
            ./hosts/${tux-laptop}/hardware-configuration.nix
            # inputs.home-manager.nixosModules.default
          ];
        };
      };
    };
}
