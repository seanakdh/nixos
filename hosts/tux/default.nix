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
    ../../system/base
    ../../users/sean
    ../../system/wm/xfce4-i3.nix
    # ../../system/wm/hyprland.nix
    ../../system/env
    ../../system/hardware/intel.nix
    ../../system/services/audio.nix
    ../../system/services/bluetooth.nix
    ../../system/services/printing.nix
    ../../system/applications/office.nix
    ../../system/applications/utils.nix
    ../../system/applications/development.nix
    ../../system/applications/vm.nix
    ../../system/fonts/nerdfonts.nix
  ];
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
