{ config, lib, pkgs, ... }:

{
  services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
  environment.systemPackages = with pkgs; [
    pulseaudioFull
    pavucontrol
  ];
}
