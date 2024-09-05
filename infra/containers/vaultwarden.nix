{
  config,
  lib,
  pkgs,
  ...
}@inputs:

{

  containers.vaultwarden = {
    autoStart = true;
    privateNetwork = true;
    hostBridge = "br0";
    hostAddress = "10.10.150.10";
    localAddress = "10.10.150.51";

    extraFlags = [ "-U" ];
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

        services.vaultwarden = {
          enable = true;
          package = pkgs.vaultwarden;
          dbBackend = "sqlite";
          environmentFile = "/run/secrets/vaultwarden-environment";
          config = {
            ROCKET_ADDRESS = "10.10.150.51";
            ROCKET_PORT = "80";
            ROCKET_LOG = "critical";
            DOMAIN = "https://vault.ohanlon.it";
            SIGNUPS_ALLOWED = "true";
            SIGNUPS_VERIFY = "false";
            SIGNUPS_DOMAINS_WHITELIST = "ohanlon.net";
            INVITATIONS_ALLOWED = "true";
            LOG_LEVEL = "info";
            LOG_FILE = "/var/lib/bitwarden_rs/log";
          };
        };

        environment.etc = {
          "fail2ban/filter.d/vaultwarden.local".text = pkgs.lib.mkDefault (
            pkgs.lib.mkAfter ''
              [INCLUDES]
              before = common.conf

              [Definition]
              failregex = ^.*Username or password is incorrect\. Try again\. IP: <ADDR>\. Username:.*$
              ignoreregex =
            ''
          );
        };
        services.fail2ban = {
          enable = true;
          jails = {
            vaultwarden.settings = {
              enabled = true;
              filter = "vaultwarden";
              # banaction = "nftables[type=allports]";
              action = "nftables[type=multiport, name=HTTP, port=\"https,http\"]";
              logpath = "/var/lib/bitwarden_rs/log";
              maxretry = 5;
              bantime = "1h";
            };
          };
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
          secrets."vaultwarden-environment" = {
            owner = "vaultwarden";
          };
        };
      };
  };
}
