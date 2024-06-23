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
      domain = "ohanlon.it";
      hosts = {
        nix-test = { };
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
              inherit hostname dom;
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
      mkHostsAndDeployList = lib.mapAttrsToList mkHostsAndDeploy hosts;
      mkHostsAndDeployMerged = lib.foldl' lib.recursiveUpdate { } mkHostsAndDeployList;
    in
    mkHostsAndDeployMerged
    // {
      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
