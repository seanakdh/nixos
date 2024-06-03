{
  config,
  lib,
  pkgs,
  ...
}@inputs:

{
  imports = with inputs; [
    ./aliases.nix
    ./networking.nix
    ./hardware-configuration.nix
    ../../system/applications/server_base.nix
    ../../system/services/nextcloud.nix
    ../../system/services/sshd.nix
    ../../system/base/sh.nix
    ../../system/base/boot.nix
    ../../system/env
    ../../users/admin
  ];
  services.qemuGuest.enable = true;
  security.sudo.wheelNeedsPassword = false;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.userActivationScripts = {
    cloneFlake = ''
      cd /etc
      # Directory to clone/operate in (replace with your desired path)
      repo_dir="/etc/nixos"

      # Check if the directory exists
      if [ ! -d "$repo_dir" ]; then
        # Not a directory, likely not cloned. Clone the repository.
        echo "Cloning repository..."
        git clone "https://github.com/seanakdh/nixos.git" "$repo_dir"
      else
        # Directory exists, likely a Git repository. Checkout HEAD.
        echo "Found existing repository. Switching to HEAD..."
        cd "$repo_dir"
        git checkout HEAD
      fi
    '';
  };
  system.stateVersion = "23.11";
}
