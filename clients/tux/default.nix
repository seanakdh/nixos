{
  config,
  lib,
  pkgs,
  ...
}@inputs:

{
  imports = with inputs; [
    ./hardware-configuration.nix
    ./networking.nix
    ./aliases.nix
    ../../users/client
    ../../system/env
    ../../system/base
    ../../system/services/client
    ../../system/applications/client
    ../../system/wm/xfce4-i3
    # ../../system/wm/hyprland.nix
    ../../system/hardware/intel.nix
    ../../system/fonts/nerdfonts.nix
  ];
  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;
  # services.opensnitch.enable = true;
  # services.opensnitch.settings.DefaultAction = "deny";
  # environment.systemPackages = with pkgs; [ opensnitch-ui ];
  system.stateVersion = "23.11";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    BROWSER = "firefox";
    TERMINAL = "xfce4-terminal";
    EDITOR = "emacs";
  };
}
