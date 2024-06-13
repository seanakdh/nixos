{
  config,
  lib,
  pkgs,
  ...
}:

{
  users.users.admin = {
    isNormalUser = true;
    initialHashedPassword = "$6$p/2/Y0xcOvxCBMH6$ky96e3IPU1yei0x3204HlktLJY1vS1biccewFqsCWj7GMK6bcf93OmO6oAK33cyGjENbcutR/gfmzV3B9Muxn/";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIgsjhqbIOIFxXMH5paIthKfcqdNVlZv85NytbvuLwvs home_default"
    ];
  };
}
