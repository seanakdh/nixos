{ config, lib, pkgs, ... }:

{
  imports =
  [
    ./base/basePackages.nix
    ./base/baseSecurity.nix
  ];
}
