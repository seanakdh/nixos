{
  config,
  lib,
  pkgs,
  hostname,
  ...
}:

{
  networking.domain = "ohanlon-it.net";
  networking.hostName = hostname;
  networking.defaultGateway = "10.10.100.254";
  networking.nameservers = [ "10.10.100.254" ];
  networking.interfaces.eth0.ipv4.addresses = [
    {
      address = "10.10.100.50";
      prefixLength = 24;
    }
  ];
  networking.nftables.enable = true;
  networking.firewall.allowedTCPPorts = [
    80
    443
    22
  ];
}
