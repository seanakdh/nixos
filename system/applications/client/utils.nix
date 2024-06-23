{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    ripgrep
    bind
    fzf
    keepassxc
    chezmoi
    git
    unrar
    unzip
    wget
    btop
    ksnip
    copyq
    du-dust
    bat
    xclip
    sqlite
    p7zip
    xarchiver
    ansible
    wireguard-tools
    inetutils
    dig
  ];
  services.locate.localuser = null;
  services.locate.package = pkgs.mlocate;
  services.locate.enable = true;
  programs.ssh.startAgent = true;
}
