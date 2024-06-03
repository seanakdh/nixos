{
  config,
  lib,
  pkgs,
  ...
}@inputs:

{
  imports = with inputs; [
    ./aliases.nix
    ./networking.nix
    ./hardware-configuration.nix
    ../../system/applications/server_base.nix
    ../../system/services/nextcloud.nix
    ../../system/base/sh.nix
    ../../system/base/boot.nix
    ../../system/env
    ../../users/admin
  ];
  services.qemuGuest.enable = true;
  security.sudo.wheelNeedsPassword = false;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "23.11";
}
