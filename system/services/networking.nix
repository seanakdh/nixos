{ config, lib, pkgs, ... }:

{
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 8080 ];
      allowedUDPPorts = [ ];
    };
    networkmanager.enable = true;
  };
}
