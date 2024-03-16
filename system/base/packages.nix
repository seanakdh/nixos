{ config, lib, pkgs, unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    killall
    chromium
    unstable.emacs
    neofetch
    vim
    firefox
    gvfs
  ];
}
