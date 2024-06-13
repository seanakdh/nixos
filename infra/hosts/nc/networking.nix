{
  config,
  lib,
  pkgs,
  hostname,
  ...
}:

{
  networking = {
    domain = "ohanlon-it.net";
    bridges.br0.interfaces = [ "eth0" ];
    hostName = hostname;
    defaultGateway = "10.10.100.254";
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
