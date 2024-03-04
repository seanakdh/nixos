{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neofetch
    vim
    firefox
    qt5ct
    gvfs
  ];
}
