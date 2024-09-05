{
  config,
  lib,
  pkgs,
  unstable,
  ...
}@inputs:

{

  containers.nextcloud = {
    autoStart = true;
    privateNetwork = true;
    hostBridge = "br0";
    hostAddress = "10.10.150.10";
    localAddress = "10.10.150.52";
    extraFlags = [ "-U" ];
    bindMounts = {
      "/var/lib/nextcloud/data" = {
        hostPath = "/nextcloud/data";
        isReadOnly = false;
      };
    };
    config =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        imports = with inputs; [
          sops-nix.nixosModules.sops
          ../../system/applications/server
          ../../system/services/server
          ../../system/env
          ../../users/server
        ];
        services.nextcloud = {
          enable = true;
          package = pkgs.nextcloud29;
          hostName = "cloud.ohanlon.it";
          config.adminpassFile = "/run/secrets/nextcloud-root-pw";
          database.createLocally = true;
          configureRedis = true;
        };
        system.stateVersion = "24.05";
        networking = {
          nftables.enable = true;
          firewall = {
            enable = true;
            allowedTCPPorts = [
              22
              80
              443
            ];
          };
          # Use systemd-resolved inside the container
          # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
          useHostResolvConf = lib.mkForce true;
        };
        sops = {
          defaultSopsFile = ../../secrets.yaml;
          defaultSopsFormat = "yaml";
          age = {
            sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
            keyFile = "/var/lib/sops-nix/keys.txt";
            generateKey = true;
          };
          secrets."nextcloud-root-pw" = {
            owner = "nextcloud";
          };
        };
      };
  };
}
