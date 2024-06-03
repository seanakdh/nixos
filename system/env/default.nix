{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  i18n.defaultLocale = "en_IE.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkForce "sg";
    useXkbConfig = true; # use xkb.options in tty.
  };
}
