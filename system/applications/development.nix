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
    nil
    unstable.vscodium
    unstable.neovim
    jdk21
    graphviz
    # unstable.nixd
    # unstable.rnix-lsp
  ];
  programs.java.enable = true;
}
