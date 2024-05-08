{ config, lib, unstable, pkgs, ... }:

{
  virtualisation.virtualbox.host.enable = true;

  # qemu
  # needed for virtmanager config store
  programs.dconf.enable = true;
  programs.virt-manager.enable = true;
  programs.virt-manager.package = unstable.virt-manager;

  ##packages needed
  environment.systemPackages = with unstable; [
    spice
    #spice-gtk
    spice-protocol
    win-spice
    virtio-win
  ];

  ##virtualisation services
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
        package = unstable.qemu;
      };
    };
    spiceUSBRedirection.enable = true;
  };
  # services.spice-vdagentd.enable = true;

}
