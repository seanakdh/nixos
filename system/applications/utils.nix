{
  config,
  lib,
  pkgs,
  unstable,
  ...
}:
let

  backup-script = pkgs.writeScriptBin "backup" ''
    #! ${pkgs.runtimeShell}

    # sleep 10

    # ${pkgs.rsync.outPath}/bin/rsync -ar /home/sean/ /mnt/backup/sean

  '';
in

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
  ];
  systemd.mounts = [
    {
      what = "/dev/backup_drive";
      where = "/mnt/backup";
      type = "ext4";
    }
  ];
  systemd.automounts = [
    {
      where = "/mnt/backup";
      wantedBy = [ "multi-user.target" ];
    }
  ];
  services.udev.extraRules = ''
    KERNEL=="sd?1", ATTRS{serial}=="S6XJNS0W739253A", SYMLINK+="backup_drive", NAME="Backup Drive", OWNER="sean", GROUP="users"
  '';
  services.locate.localuser = null;
  services.locate.package = pkgs.mlocate;
  services.locate.enable = true;
  programs.ssh.startAgent = true;
}
