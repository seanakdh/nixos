{ config
, lib
, pkgs
, ...
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
    nixpkgs-fmt
    vscodium
    jdk21
    graphviz
    shfmt
    shellcheck
    ripgrep
    wordnet
    ghc
    haskell-language-server
    cabal-install
    go
    gopls
    golangci-lint-langserver
    golangci-lint
    impl
    gotests
    nodePackages_latest.vscode-html-languageserver-bin
    nodePackages_latest.vscode-css-languageserver-bin
    delve
    docker
  ];
  programs.java.enable = true;
}
