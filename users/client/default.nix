{
  config,
  lib,
  pkgs,
  username,
  ...
}:

{
  users.users.${username} = {
    isNormalUser = true;
    hashedPassword = "$6$D9MLMJyV2ntwsa/4$74mRG8iU3jUTHIhMRz/GnHSEq4lPBXr4jikklIoculABuq5gDo5ILzVxLQvOU1EN1mrGxi6k.tCjXwlT6DJia0";
    extraGroups = [
      "libvirtd"
      "user-with-access-to-virtualbox"
      "networkmanager"
      "wheel"
      "lp"
      "audio"
      "input"
      "video"
      "users"
      "dialout"
    ];
  };
  networking = {
    wireguard.enable = true;
    wg-quick.interfaces = {
      wg0 = {
        autostart = false;
        address = [ "10.1.100.2/24" ];
        dns = [ "10.10.100.254" ];
        listenPort = 51820;
        privateKeyFile = "/home/${username}/.wireguard/privatekey";
        peers = [
          {
            publicKey = "oOgVIATocS5Szdm03/HLxYlBN6NpiMB36jWlsLtuHio=";
            allowedIPs = [ "0.0.0.0/0" ];
            endpoint = "ohanlon.it:51820";
          }
        ];
      };
    };
  };
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
