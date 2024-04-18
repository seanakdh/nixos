{ config, lib, pkgs, hostname, ... }:

{
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
    networkmanager.enable = true;
    hostName = hostname;
  };
}
