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
    ../../containers/nextcloud.nix
    ../../../system/applications/server
    ../../../system/services/server/nextcloud.nix
    ../../../system/services/server
    ../../../system/base/sh.nix
    ../../../system/base/boot.nix
    ../../../system/env
    ../../../users/server
  ];
  nix.settings.trusted-users = [
    "admin"
    "sean"
  ];
  services.qemuGuest.enable = true;
  security.sudo.wheelNeedsPassword = false;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "23.11";
}
