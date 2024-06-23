{
  config,
  lib,
  pkgs,
  username,
  home-manager,
  ...
}@inputs:

{
  imports = with inputs; [
    ./ssh.nix
    ./audio.nix
    ./printing.nix
    ./bluetooth.nix
  ];
}
