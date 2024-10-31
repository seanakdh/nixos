{
  description = "Nixos config flake for multiple Hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    zig.url = "github:mitchellh/zig-overlay";
    odin.url = "github:seanakdh/odin-overlay";
    zls-flake.url = "github:zigtools/zls";
    # home-manager = {
    # url = "github:nix-community/home-manager/master";
    # The `follows` keyword in inputs is used for inheritance.
    # Here, `inputs.nixpkgs` of home-manager is kept consistent with
    # the `inputs.nixpkgs` of the current flake,
    # to avoid problems caused by different versions of nixpkgs.
    # inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      zig,
      odin,
      zls-flake,
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
                  overlays = [
                    zig.overlays.default
                    odin.overlays.default
                  ];
                  inherit system;
                  config.allowUnfree = allowUnfree;
                };
                zls-package = zls-flake.packages.${system}.default;
                unstable = import nixpkgs-unstable {
                  inherit system;
                  config.allowUnfree = allowUnfree;
                };
              };
              modules = with inputs zls-package; [ ./clients/${hostname} ];
            };
        in
        nixpkgs.lib.mapAttrs mkHost {
          tux = {
            username = "sean";
          };
        };
    };
}
