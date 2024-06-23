{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    waybar
    mako
    libnotify
    swww
    kitty
    rofi-wayland
    networkmanagerapplet
    brightnessctl
    playerctl
    pamixer
    hyprshot
    qt5ct
    libsForQt5.qt5.qtwayland
    swaylock
    libsForQt5.breeze-icons
    # mpd
  ];
  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
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
  services.displayManager = {
    defaultSession = "hyprland";
  };

  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    # systemdTarget = "hyprland-session.target";
    wantedBy = [ "hyprland-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c ~/.config/kanshi/config'';
    };
  };
}
