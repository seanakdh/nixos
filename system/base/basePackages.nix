{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neofetch
    vim
    # btop
    # ksnip
    # copyq
    firefox
    qt5ct
    # system-config-printer
    # skanlite
    # hplip
    # networkmanagerapplet
    # pulseaudioFull
    # pavucontrol
    gvfs
    # git
    # polkit
    # gnome.gnome-keyring
    # unrar
    # unzip
    # wget
  ];
}
