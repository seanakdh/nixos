{
  config,
  lib,
  pkgs,
  hostname,
  ...
}:

{
  networking = {
    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ 51820 ];
    };
    networkmanager.enable = true;
    hostName = hostname;
  };
}
