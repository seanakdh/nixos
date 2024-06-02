{
  config,
  lib,
  pkgs,
  unstable,
  ...
}@args:

with args;
{
  environment.systemPackages = with pkgs; [
    libtool
    gcc
    gnumake
    cmake
    unstable.kotlin-language-server
    kotlin
    ktlint
    unstable.rust-analyzer
    unstable.rustc
    unstable.cargo
    unstable.rustfmt
    jetbrains.idea-community
    nil
    nixfmt-rfc-style
    unstable.vscodium
    jdk21
    graphviz
    shfmt
    shellcheck
    ripgrep
    sqlite
    wordnet
  ];
  programs.java.enable = true;
}
