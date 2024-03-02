{ config, lib, pkgs, ... }:

{
  services.xserver = {
    xkb.layout = "ch";
    xkb.variant = "de_nodeadkeys";
    enable = true;
    videoDrivers = ["modesetting"];
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3status
        dmenu
        picom
        nitrogen
      ];
    };
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
    displayManager = {
      lightdm.enable = true;
      defaultSession = "xfce+i3";
    };
  };
  environment.xfce.excludePackages = with pkgs; [
            xfce.xfce4-appfinder
            xfce.xfce4-screenshooter
            xfce.xfce4-taskmanager
  ];
}
