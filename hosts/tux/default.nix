{ config, lib, pkgs, unstable, tux-laptop, ... }:

{
  imports = with unstable pkgs; [
    ./configuration.nix
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
    ../../system/fonts/nerdfonts.nix
  ];
  nixpkgs.config.allowUnfree = true;

  virtualisation.virtualbox.host.enable = true;

  programs.light.enable = true;

  networking.hostName = tux-laptop;

  console.keyMap = "sg";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "23.11"; # Did you read the comment?
}
