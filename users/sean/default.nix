{
  config,
  lib,
  pkgs,
  ...
}@args:

with args;
{
  users.users.sean = {
    isNormalUser = true;
    description = "sean";
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

    packages = with pkgs; [
      # chromium
      # unstable.emacs
    ];
  };
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
