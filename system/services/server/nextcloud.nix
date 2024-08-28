{
  config,
  lib,
  pkgs,
  ...
}@inputs:

with inputs;
{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29;
    hostName = "cloud.ohanlon.it";
    config.adminpassFile = "/run/secrets/nextcloud-root-pw";
    settings = {
      overwriteprotocol = "https";
      trusted_proxies = [ "10.10.150.50" ];
    };
  };
}
