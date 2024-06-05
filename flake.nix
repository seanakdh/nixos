{
  description = "Nixos config flake for multiple Hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
    }@inputs:
    let
      allowUnfree = true;
    in
    {
      nixosConfigurations =
        let
          mkHost =
            hostname:
            {
              system ? "x86_64-linux",
            }:
            nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit hostname system;
                pkgs = import nixpkgs {
                  inherit system;
                  config.allowUnfree = allowUnfree;
                };
                unstable = import nixpkgs-unstable {
                  inherit system;
                  config.allowUnfree = allowUnfree;
                };
              };
              modules = [ ./clients/${hostname} ];
            };
        in
        nixpkgs.lib.mapAttrs mkHost { tux = { }; };
    };
}
