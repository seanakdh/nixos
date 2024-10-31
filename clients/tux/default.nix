{
  config,
  lib,
  pkgs,
  unstable,
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
    ../../system/wm/hyprland.nix
    ../../system/hardware/intel.nix
    ../../system/fonts/nerdfonts.nix
  ];
  system.stateVersion = "23.11";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    BROWSER = "librewolf";
    TERMINAL = "xfce4-terminal";
    EDITOR = "nvim";
  };
}
