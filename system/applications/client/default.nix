{
  config,
  lib,
  pkgs,
  ...
}@inputs:

{
  imports = with inputs; [
    ./vm.nix
    ./utils.nix
    ./office.nix
    ./development.nix
  ];
  environment.systemPackages = with pkgs; [
    git
    killall
    chromium
    emacs
    neofetch
    firefox
    gvfs
    polkit
    gnome.gnome-keyring
    deploy-rs
  ];
  programs.neovim = {
    enable = true;
    vimAlias = true;
  };
  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;
}
