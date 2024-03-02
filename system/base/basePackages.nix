{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    neofetch
    vim
    btop
    libtool
    gcc
    gnumake
    cmake
    ksnip
    copyq
    firefox
    # lxappearance
    qt5ct
    system-config-printer
    skanlite
    hplip
    networkmanagerapplet
    pulseaudioFull
    pavucontrol
    gnome.gnome-keyring
    gvfs
    git
    polkit
    unrar
    unzip
    wget
    xfce.thunar-volman
  ];
}
