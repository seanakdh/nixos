{
  description = "Home Server Infrastructure flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    deploy-rs.url = "github:serokell/deploy-rs";
  };

  outputs =
    {
      self,
      nixpkgs,
      deploy-rs,
    }:
    let
      inherit (nixpkgs) lib;
      domain = "ohanlon-it.net";
      hosts = {
        nc = { };
      };
      mkHostsAndDeploy =
        hostname:
        {
          system ? "x86_64-linux",
          dom ? domain,
        }:
        {
          nixosConfigurations.${hostname} = lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit hostname;
            };
            modules = [ ./hosts/${hostname} ];
          };
          deploy.nodes.${hostname} = {
            hostname = "${hostname}.${dom}";
            profiles.system = {
              user = "root";
              sshUser = "admin";
              path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.${hostname};
            };
          };
        };

      # Here, we have the following list:
      #
      #     [
      #       {
      #         nixosConfigurations.nc = /* … */;
      #         deploy.nodes.nc = /* … */;
      #       }
      #
      #       {
      #         nixosConfigurations.tux = /* … */;
      #         deploy.nodes.tux = /* … */;
      #       }
      #     ]
      mkHostsAndDeployList = lib.mapAttrsToList mkHostsAndDeploy hosts;

      # Here, we have the following attribute set:
      #
      #     {
      #       nixosConfigurations = {
      #         nc = /* … */;
      #         tux = /* … */;
      #       };
      #       deploy.nodes = {
      #         nc = /* … */;
      #         tux = /* … */;
      #       };
      #     }
      #
      # This already matches the shape Flake `outputs` function should return.
      #
      # `foldl'` (called `reduce` in JavaScript) is basically a loop.
      # Here, specifically, we repeatedly recursively merge the attribute sets
      # from the `nixosConfigurationsAndDeploysList` into the result set,
      # starting with an empty attribute set.
      mkHostsAndDeployMerged = lib.foldl' lib.recursiveUpdate { } mkHostsAndDeployList;
    in
    mkHostsAndDeployMerged
    // {
      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
