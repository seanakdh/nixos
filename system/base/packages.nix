{
  config,
  lib,
  pkgs,
  unstable,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    killall
    chromium
    unstable.emacs
    neofetch
    firefox
    gvfs
  ];
  programs.neovim = {
    enable = true;
    vimAlias = true;
  };
}
