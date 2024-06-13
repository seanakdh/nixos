{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    libtool
    gcc
    gnumake
    cmake
    kotlin-language-server
    kotlin
    ktlint
    rust-analyzer
    rustc
    cargo
    rustfmt
    jetbrains.idea-community
    nil
    nixfmt-rfc-style
    vscodium
    jdk21
    graphviz
    shfmt
    shellcheck
    ripgrep
    sqlite
    wordnet
    ghc
    haskell-language-server
    cabal-install
  ];
  programs.java.enable = true;
}
