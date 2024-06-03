{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { ... }@inputs:
    let
      allowUnfree = true;
      tux = with inputs; rec {

        system = "x86_64-linux";

        specialArgs = {

          hostname = "tux";
          inherit system;

          unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = allowUnfree;
          };

          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = allowUnfree;
          };
        };
        modules = [ ./hosts/${specialArgs.hostname} ];
      };
      nc = with inputs; rec {
        system = "x86_64-linux";

        specialArgs = {
          hostname = "nc";
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = allowUnfree;
          };
          modules = [ ./hosts/${specialArgs.hostname} ];
        };
      };
    in
    with inputs;
    {
      nixosConfigurations = {

        ${tux.specialArgs.hostname} = nixpkgs.lib.nixosSystem { inherit (tux) system specialArgs modules; };
        ${nc.specialArgs.hostname} = nixpkgs.lib.nixosSystem { inherit (nc) system specialArgs modules; };
      };
    };
}
