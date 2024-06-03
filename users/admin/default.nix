{
  config,
  lib,
  pkgs,
  ...
}:

{
  users.users.admin = {
    isNormalUser = true;
    initialPassword = "GTA5@1220";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIgsjhqbIOIFxXMH5paIthKfcqdNVlZv85NytbvuLwvs home_default"
    ];
  };
}
