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
    ../../system/services/sshd.nix
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
  system.userActivationScripts = {
    cloneFlake = ''
      cd /etc
      ${pkgs.git}/bin/git clone https://github.com/seanakdh/nixos 2>/dev/null
    '';
  };
  system.stateVersion = "23.11";
}
