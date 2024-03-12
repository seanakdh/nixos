{ config, lib, pkgs, unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    chromium
    unstable.emacs
    neofetch
    vim
    firefox
    gvfs
  ];
}
