{ config, lib, pkgs, hostname, ... }:

{
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 8080 ];
      allowedUDPPorts = [ ];
    };
    networkmanager.enable = true;
    hostName = hostname;
  };
}
