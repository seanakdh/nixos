{ config, lib, pkgs, ... }:

{
   networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
    networkmanager.enable = true;
  };
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
