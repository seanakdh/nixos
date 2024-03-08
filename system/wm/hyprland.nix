{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    waybar
    mako
    libnotify
    swww
    kitty
    rofi-wayland
    networkmanagerapplet
    kanshi
    # mpd
  ];
  xdg = {
    portal = {
      enable = true;
      extraPortals= [pkgs.xdg-desktop-portal-gtk];
    };
  };

  services.xserver = {
    xkb.layout = "ch";
    xkb.variant = "de_nodeadkeys";
    enable = true;
    displayManager.lightdm.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.light.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };



  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    # systemdTarget = "hyprland-session.target";
    wantedBy = ["hyprland-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c ~/.config/kanshi/config'';
    };
  };
}
