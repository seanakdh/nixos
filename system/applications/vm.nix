{ config, lib, unstable, pkgs, ... }:

{
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.package = unstable.virtualbox;
  # virtualisation.vmware.host.enable = true;
  # virtualisation.vmware.host.package = unstable.vmware-workstation;
  # qemu
  # needed for virtmanager config store
  # programs.dconf.enable = true;
  # programs.virt-manager.enable = true;
  # programs.virt-manager.package = pkgs.virt-manager;

  # ##packages needed
  # environment.systemPackages = with pkgs; [
  #   spice
  #   #spice-gtk
  #   spice-protocol
  #   win-spice
  #   virtio-win
  # ];

  # ##virtualisation services
  # virtualisation = {
  #   libvirtd = {
  #     enable = true;
  #     qemu = {
  #       swtpm.enable = true;
  #       ovmf.enable = true;
  #       ovmf.packages = [ pkgs.OVMFFull.fd ];
  #       package = pkgs.qemu;
  #     };
  #   };
  #   spiceUSBRedirection.enable = true;
  # };

}
