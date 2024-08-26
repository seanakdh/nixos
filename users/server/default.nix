{
  config,
  lib,
  pkgs,
  ...
}:

{
  users.users.admin = {
    isNormalUser = true;
    initialHashedPassword = "$6$0ZuNPkA6KbHb4z5O$tdD/dbvuj5HLIOYIcguhKowYrXlTzZ9uF2EtBcLsIarz7oPMW7ZxdFgHp45VY/DBzzmKgA1No569c2vQmV5HA1";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIgsjhqbIOIFxXMH5paIthKfcqdNVlZv85NytbvuLwvs home_default"
    ];
  };
}
