{
  config,
  lib,
  pkgs,
  ...
}:

{
  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIgsjhqbIOIFxXMH5paIthKfcqdNVlZv85NytbvuLwvs home_default"
    ];
  };
  security.sudo.wheelNeedsPassword = false;
}
