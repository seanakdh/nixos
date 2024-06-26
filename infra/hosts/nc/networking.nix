{
  config,
  lib,
  pkgs,
  hostname,
  dom,
  ...
}:

{
  networking = {
    domain = dom;
    bridges.br0.interfaces = [ "eth0" ];
    hostName = hostname;
    nameservers = [ "10.10.100.254" ];
    defaultGateway = {
      address = "10.10.100.254";
      interface = "br0";
    };
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
      # Lazy IPv6 connectivity for the container
      enableIPv6 = false;
    };
    nftables.enable = true;
    firewall.allowedTCPPorts = [
      80
      22
    ];
  };
}
