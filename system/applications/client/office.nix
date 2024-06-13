{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    libreoffice
    zim
    nextcloud-client
    spotify
    obsidian
    evolution
  ];
}
