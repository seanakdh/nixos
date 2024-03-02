{ config, lib, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "i915.force_probe=46a6" ];
  powerManagement.cpuFreqGovernor = "performance";
}
