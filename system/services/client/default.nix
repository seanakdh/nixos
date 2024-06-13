{
  config,
  lib,
  pkgs,
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
