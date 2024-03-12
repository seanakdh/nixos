{ config, lib, pkgs, ... }:

{
  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    BROWSER = "firefox";
    TERMINAL = "xfce4-terminal";
    EDITOR = "emacs";
  };

  i18n.defaultLocale = "en_IE.UTF-8";
  time.timeZone = "Europe/Zurich";
  console.keyMap = "sg";
}
