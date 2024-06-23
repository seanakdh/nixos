{
  config,
  lib,
  pkgs,
  ...
}:

{
  fonts.packages = with pkgs; [
    nerdfonts
    noto-fonts
    font-awesome
  ];
}
