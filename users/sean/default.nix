{ config, lib, pkgs, ... }:

{
  users.users.sean = {
    isNormalUser = true;
    description = "sean";
    hashedPassword = "$6$D9MLMJyV2ntwsa/4$74mRG8iU3jUTHIhMRz/GnHSEq4lPBXr4jikklIoculABuq5gDo5ILzVxLQvOU1EN1mrGxi6k.tCjXwlT6DJia0";
    extraGroups = [ "user-with-access-to-virtualbox" "networkmanager" "wheel" "lp" "audio" "input" "video" "users" ];
    packages = with pkgs; [
      # chromium
      # unstable.emacs
    ];
  };
}
