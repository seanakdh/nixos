{
  description = "Nixos config flake for multiple Hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    zig.url = "github:mitchellh/zig-overlay";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixpkgs-unstable,
      zig,
    }@inputs:
    let
      allowUnfree = true;
    in
    with inputs;
    {
      nixosConfigurations =
        let
          mkHost =
            hostname:
            {
              system ? "x86_64-linux",
              username ? "admin",
            }:
            nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit hostname system username;
                pkgs = import nixpkgs {
                  overlays = [ zig.overlays.default ];
                  inherit system;
                  config.allowUnfree = allowUnfree;
                };
                unstable = import nixpkgs-unstable {
                  inherit system;
                  config.allowUnfree = allowUnfree;
                };
              };
              modules = with inputs; [ ./clients/${hostname} ];
            };
        in
        nixpkgs.lib.mapAttrs mkHost {
          tux = {
            username = "sean";
          };
        };
    };
}
