{ config, lib, pkgs, unstable, hostname, nixpkgs-usntable, ... }:

{
  imports = with unstable hostname; [
    ./hardware-configuration.nix
    ../../system/base
    ../../users/sean
    ../../system/wm/xfce4-i3.nix
    # ../../system/wm/hyprland.nix
    ../../system/env
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
