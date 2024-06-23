{
  config,
  lib,
  pkgs,
  hostname,
  dom,
  ...
}:
let
  bridge = "br0";
in
{
  networking = {
    domain = dom;
    bridges.br0.interfaces = [ "eth0" ];
    hostName = hostname;
    defaultGateway.address = "10.10.100.254";
    nameservers = [ "10.10.100.254" ];
    interfaces.br0.ipv4.addresses = [
      {
        address = "10.10.100.50";
        prefixLength = 24;
      }
    ];
    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
      externalInterface = "br0";
      enableIPv6 = false;
    };
    nftables.enable = true;
    firewall.allowedTCPPorts = [
      80
      22
    ];
  };
}
