{
  description = "Home Server Infrastructure flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    deploy-rs.url = "github:serokell/deploy-rs";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      deploy-rs,
      unstable,
      sops-nix,
    }@inputs:
    let
      inherit (nixpkgs) lib;
      domain = "ohanlon.it";
      hosts = {
        nix-test = { };
        nix-prod = { };
      };
      mkHostsAndDeploy =
        hostname:
        {
          system ? "x86_64-linux",
          dom ? domain,
        }:
        with inputs;
        {
          nixosConfigurations.${hostname} = lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit hostname dom sops-nix;
            };
            modules = with inputs; [ ./hosts/${hostname} ];
          };
          deploy.nodes.${hostname} = {
            hostname = "${hostname}.${dom}";
            profiles.system = {
              user = "root";
              sshUser = "admin";
              path = deploy-rs.lib.${system}.activate.nixos self.nixosConfigurations.${hostname};
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
