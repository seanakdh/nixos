{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    htop
    curl
    tmux
  ];
}
