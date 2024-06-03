{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    vim
    wget
    htop
    tmux
  ];
}
