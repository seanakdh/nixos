{
  config,
  lib,
  pkgs,
  unstable,
  ...
}@inputs:

{
  imports = with inputs; [
    sops-nix.nixosModules.sops
    ./aliases.nix
    ./networking.nix
    ./hardware-configuration.nix
    ../../containers/vaultwarden.nix
    ../../containers/nginx.nix
    # ../../containers/nextcloud.nix
    ../../../system/applications/server
    ../../../system/services/server
    ../../../system/services/server/nextcloud.nix
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

  sops = {
    defaultSopsFile = ../../../secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/keys.txt";
      generateKey = true;
    };
    secrets."nextcloud-root-pw" = {
      owner = "nextcloud";
    };
  };
  system.stateVersion = "23.11";
}
