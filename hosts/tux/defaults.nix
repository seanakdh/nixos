{ config, lib, pkgs, tux-laptop, ... }:

{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ../../system/base.nix
    ../../system/sh.nix
    ../../system/networking.nix
    ../../system/wm/xfce4-i3.nix
  ];
  networking.hostName = tux-laptop;
}
