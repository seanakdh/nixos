{
  config,
  lib,
  pkgs,
  ...
}@inputs:

with inputs;
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
    clippy
    jetbrains.idea-community
    nil
    nixfmt-rfc-style
    nixpkgs-fmt
    vscodium
    (zulu.override { enableJavaFX = true; })
    jdk21
    graphviz
    shfmt
    shellcheck
    ripgrep
    wordnet
    ghc
    haskell-language-server
    cabal-install
    unstable.go
    unstable.godef
    unstable.gopls
    unstable.golangci-lint-langserver
    unstable.golangci-lint
    templ
    impl
    gotests
    delve
    httpie
    lldb_16
    zigpkgs.master
    sbcl
    rlwrap
    zls-package
  ];
  programs.java.enable = true;
}
