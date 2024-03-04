{ config, lib, pkgs, unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    ripgrep
    bind
    fzf
    keepassxc
    chezmoi
    git
    unrar
    unzip
    wget
    btop
    ksnip
    copyq
  ];
  services.locate.enable = true;
  programs.ssh.startAgent = true;
}
