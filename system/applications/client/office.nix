{ config, lib, pkgs, unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    libreoffice
    zim
    nextcloud-client
    spotify
    unstable.obsidian
    evolution
  ];
}
