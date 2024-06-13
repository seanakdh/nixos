{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./boot.nix
    ./sh.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "23.11";
}
