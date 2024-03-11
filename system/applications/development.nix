{ config, lib, pkgs, unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    libtool
    gcc
    gnumake
    cmake
    unstable.kotlin-language-server
    kotlin
    unstable.rust-analyzer
    unstable.rustc
    unstable.cargo
    unstable.rustfmt
    jetbrains.idea-community
    nixd
  ];
  programs.java.enable = true;
}
