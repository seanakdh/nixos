{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29;
    hostName = "nc.ohanlon-it.net";
    config.adminpassFile = "/etc/nextcloud-admin-pass";
  };
}
