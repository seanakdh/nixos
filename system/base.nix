{ config, lib, pkgs, unstable, ... }:

{
  imports =
  [
    ./base/packages.nix
    ./base/security.nix
    ./base/boot.nix
    ./base/sh.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  i18n.defaultLocale = "en_IE.UTF-8";
  time.timeZone = "Europe/Zurich";
  console.keyMap = "sg";

  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    BROWSER = "firefox";
    TERMINAL = "xfce4-terminal";
    EDITOR = "emacs";
  };

  users.users.sean = {
    isNormalUser = true;
    description = "sean";
    initialPassword = "change@me!";
    extraGroups = [ "user-with-access-to-virtualbox" "networkmanager" "wheel" "lp" "audio" "input" "video" "users" ];
    packages = with pkgs; [
      chromium
      unstable.emacs
    ];
  };

}
