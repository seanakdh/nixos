{
  config,
  lib,
  pkgs,
  ...
}@inputs:

{

  containers.nginx = {
    autoStart = true;
    privateNetwork = true;
    hostBridge = "br0";
    hostAddress = "10.10.150.10";
    localAddress = "10.10.150.50";

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
          ../../system/applications/server
          ../../system/services/server
          ../../system/env
          ../../users/server
        ];

        users.users.nginx.extraGroups = [ "acme" ];
        services.nginx = {
          enable = true;
          recommendedProxySettings = true;
          recommendedTlsSettings = true;
          virtualHosts = {
            "cloud.ohanlon.it" = {
              enableACME = true;
              # forceSSL = true;
              forceSSL = true;
              locations."/" = {
                # root =  "/var/www";
                proxyPass = "http://10.10.150.10:80";
                proxyWebsockets = true;
                extraConfig = "client_max_body_size 0;";
              };
              # locations."/.well-known/acme-challenge".root = "/var/lib/acme/acme-challenge/.well-known/acme-challenge";
            };
            "vault.ohanlon.it" = {
              enableACME = true;
              forceSSL = true;
              locations."/" = {
                proxyPass = "http://10.10.150.51:80";
                proxyWebsockets = true;
              };
              locations."/admin" = {
                return = 404;
              };
              # locations."/.well-known/acme-challenge".root = "/var/lib/acme/acme-challenge/.well-known/acme-challenge";
            };
          };
        };
        security.acme.acceptTerms = true;
        security.acme.defaults.email = "sean@ohanlon.net";
        # security.acme.defaults.server = "https://acme-staging-v02.api.letsencrypt.org/directory";

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
      };
  };
}
