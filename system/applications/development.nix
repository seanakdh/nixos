{ config, lib, pkgs, unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    libtool
    gcc
    gnumake
    cmake
    unstable.kotlin-language-server
    kotlin
    rust-analyzer
    rustc
    cargo
    jetbrains.idea-community
    nixd
  ];
  programs.java.enable = true;
}