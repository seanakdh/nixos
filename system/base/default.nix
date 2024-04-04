{ config, lib, pkgs, unstable,  ... }:

{
  imports = with unstable;
  [
    ./packages.nix
    ./security.nix
    ./boot.nix
    ./sh.nix
  ];
  nix.settings.experimental-features = ["nix-command" "flakes"];
  system.stateVersion = "23.11";
}
