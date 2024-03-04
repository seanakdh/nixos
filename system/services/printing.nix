{ config, lib, pkgs, ... }:

{
   services.printing.enable = true;
   services.avahi = {
       enable = true;
       nssmdns = true;
       openFirewall = true;
   };
   environment.systemPackages = with pkgs; [
     system-config-printer
     skanlite
     hplip
   ];
}
