{
  config,
  lib,
  pkgs,
  hostname,
  ...
}:

{
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ 51820 ];
    };
    networkmanager.enable = true;
    hostName = hostname;
    wireguard.enable = true;
    wg-quick.interfaces = {
      wg0 = {
        address = [ "10.1.100.2/24" ];
        dns = [ "10.10.100.254" ];
        listenPort = 51820;
        privateKeyFile = "/home/sean/.wireguard/privatekey";
        peers = [
          {
            publicKey = "oOgVIATocS5Szdm03/HLxYlBN6NpiMB36jWlsLtuHio=";
            allowedIPs = [
              "10.1.100.0/24"
              "10.10.100.0/24"
              "10.10.150.0/24"
            ];
            endpoint = "ohanlon.ddns.net:51820";
          }
        ];
      };
    };
  };
}
