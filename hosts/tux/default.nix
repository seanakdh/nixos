{ config, lib, pkgs, unstable, hostname, ... }:

{
  imports = with unstable hostname; [
    ./hardware-configuration.nix
    ../../system/base
    ../../system/wm/xfce4-i3.nix
    # ../../system/wm/hyprland.nix
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
}
