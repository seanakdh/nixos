{
  description = "Nixos config flake for multiple Hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

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
                  inherit system;
                  config.allowUnfree = allowUnfree;
                };
                unstable = import nixpkgs-unstable {
                  inherit system;
                  config.allowUnfree = allowUnfree;
                };
              };
              modules = with inputs; [
                ./clients/${hostname}

                # home-manager.nixosModules.home-manager
                # {
                #   home-manager.useGlobalPkgs = true;
                #   home-manager.useUserPackages = true;
                #   home-manager.backupFileExtension = "backup";
                #   home-manager.extraSpecialArgs = {
                #     inherit username;
                #   };

                #   # TODO replace ryan with your own username
                #   home-manager.users.${username}.imports = [ ./users/client/home.nix ];
                #   # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
                # }
              ];
            };
        in
        nixpkgs.lib.mapAttrs mkHost {
          tux = {
            username = "sean";
          };
        };
    };
}
