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
    bitwarden
    chezmoi
    git
    unrar
    unzip
    wget
    btop
    ksnip
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
    krusader
    jq
    picocom
    bitwig-studio
    gns3-gui
    gns3-server
    sops
    age
    ssh-to-age
  ];
  services.locate.localuser = null;
  services.locate.package = pkgs.mlocate;
  services.locate.enable = true;
  programs.ssh.startAgent = true;
  programs.lazygit = {
    enable = true;
    settings = {
      gui.theme = {
        lightTheme = false;
      };
    };
  };
}
