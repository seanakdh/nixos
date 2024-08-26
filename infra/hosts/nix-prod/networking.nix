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
    bridges.${bridge}.interfaces = [ "eth0" ];
    hostName = hostname;
    defaultGateway.address = "10.10.150.254";
    nameservers = [ "10.10.150.254" ];
    interfaces.${bridge}.ipv4.addresses = [
      {
        address = "10.10.150.10";
        prefixLength = 24;
      }
    ];
    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
      externalInterface = bridge;
      enableIPv6 = false;
    };
    nftables.enable = true;
    firewall.allowedTCPPorts = [
      80
      22
    ];
  };
}
