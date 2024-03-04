{ config, lib, pkgs, unstable, tux-laptop, ... }:

{
  imports = with unstable pkgs; [
    # ./configuration.nix
    ./hardware-configuration.nix
    ../../system/base.nix
    ../../system/base/sh.nix
    ../../system/wm/xfce4-i3.nix
    ../../system/hardware/intel.nix
    ../../system/services/audio.nix
    ../../system/services/networking.nix
    ../../system/services/bluetooth.nix
    ../../system/services/printing.nix
    ../../system/applications/office.nix
    ../../system/applications/utils.nix
    ../../system/applications/development.nix
    ../../system/applications/virtualbox.nix
    ../../system/fonts/nerdfonts.nix
  ];
  networking.hostName = tux-laptop;
  system.stateVersion = "23.11"; # Did you read the comment?
}
