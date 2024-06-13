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
    hostAddress = "10.10.100.50";
    localAddress = "10.10.100.51";
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
          ../../users/admin
        ];
        services.nginx = {
          enable = true;
          virtualHosts = {
            "ohanlon.it" = { };
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
          useHostResolvConf = lib.mkForce false;
        };
      };
  };
}
