{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.xserver = {
    xkb.layout = "ch";
    xkb.variant = "de_nodeadkeys";
    enable = true;
    videoDrivers = [ "modesetting" ];
    windowManager.i3 = {
      enable = true;
      configFile = ./i3/config;
      extraPackages = with pkgs; [
        i3status
        dmenu
        picom
        nitrogen
        qt5ct
        xfce.thunar-volman
        xfce.thunar-archive-plugin
      ];
    };
    displayManager.lightdm.enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
  };
  services.displayManager = {
    defaultSession = "xfce+i3";
  };
  programs.thunar.plugins = [
    pkgs.xfce.thunar-archive-plugin
    pkgs.gnome.gnome-disk-utility
  ];
  environment.xfce.excludePackages = with pkgs; [
    xfce.xfce4-appfinder
    xfce.xfce4-screenshooter
    xfce.xfce4-taskmanager
  ];
  programs.light.enable = true;
}
