{
  config,
  lib,
  pkgs,
  ...
}@inputs:

{
  imports = with inputs; [
    ../../system/services/nextcloud.nix
    ../../system/base/sh.nix
    ../../system/base/boot.nix
    ../../system/env
    ../../users/admin
    ../../system/applications/server_base.nix
    ./networking.nix
    ./hardware-confiuration.nix
  ];
  services.qemuGuest.enable = true;
  security.sudo.wheelNeedsPassword = false;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "23.11";
}
