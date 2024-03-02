# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, unstable, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "i915.force_probe=46a6" ];
  powerManagement.cpuFreqGovernor = "performance";
  # sound.enable = true;
  #hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

  # networking = {
  #   firewall = {
  #     enable = true;
  #     allowedTCPPorts = [ ];
  #     allowedUDPPorts = [ ];
  #   };
  #   hostName = "tux";
  #   networkmanager.enable = true;
  # };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IE.UTF-8";


  # Configure console keymap
  console.keyMap = "sg";
  # Environment variables
  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
    EDITOR = "emacs";
  };

  services = {
    # xserver = {
    #   xkb.layout = "ch";
    #   xkb.variant = "de_nodeadkeys";
    #   enable = true;
    #   videoDrivers = ["modesetting"];
    #   windowManager.i3 = {
    #     enable = true;
    #     extraPackages = with pkgs; [
    #       i3status
    #       # i3lock
    #       dmenu
    #       picom
    #       nitrogen
    #     ];
    #   };
    #   desktopManager = {
    #     xterm.enable = false;
    #     xfce = {
    #       enable = true;
    #       noDesktop = true;
    #       enableXfwm = false;
    #     };
    #   };
    #   displayManager = {
    #     lightdm.enable = true;
    #     defaultSession = "xfce+i3";
    #   };
    # };
    # autorandr.enable = true;

    locate.enable = true;
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
    };
  };

  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "i965"; }; # Force intel-media-driver

  # environment.xfce.excludePackages = with pkgs; [
  #           xfce.xfce4-appfinder
  #           xfce.xfce4-screenshooter
  #           xfce.xfce4-taskmanager
  # ];


  #enable zsh
  # programs.zsh = {
  #   enable = true;
  #   shellAliases = {
  #     ll = "ls -al";
  #     update = "sudo nixos-rebuild switch --cores 5";
  #     upgrade = "sudo nixos-rebuild switch --upgrade";
  #   };
    # enableCompletion = true;
    # enableLsColors = true;
    # autosuggestions.enable = true;
    # autosuggestions.async = true;
    # setOptions = [
    #   "VI"
    #   "HIST_IGNORE_DUPS"
    #   "SHARE_HISTORY"
    #   "HIST_FCNTL_LOCK"
    # ];
    # histSize = 10000;
    # histFile = "~/.zsh_history";
  # };

  programs.ssh.startAgent = true;
  programs.light.enable = true;
  programs.java.enable = true;

  virtualisation.virtualbox.host.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sean = {
    isNormalUser = true;
    description = "sean";
    initialPassword = "change@me!";
    extraGroups = [ "user-with-access-to-virtualbox" "networkmanager" "wheel" "lp" "audio" "video" "users" ];
    packages = with pkgs; [
      chezmoi
      neovim
      ripgrep
      vim
      zim
      krusader
      keepassxc
      nextcloud-client
      chromium
      cargo
      unstable.emacs
      rustc
      rust-analyzer
      kotlin
      unstable.kotlin-language-server
      # inputs.unstable.legacyPackages."${pkgs.system}".kotlin-language-server
      nil
      jetbrains.idea-community
      spotify
      libreoffice
    ];
  };

  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;

  # Fonts
  fonts.packages = with pkgs; [
    nerdfonts
  ];

  # security = {
  #   polkit.enable = true;
  #   rtkit.enable = true;
  # };

  # systemd = {
  #   user.services.polkit-gnome-authentication-agent-1 = {
  #     description = "polkit-gnome-authentication-agent-1";
  #     wantedBy = [ "graphical-session.target" ];
  #     wants = [ "graphical-session.target" ];
  #     after = [ "graphical-session.target" ];
  #     serviceConfig = {
  #       Type = "simple";
  #       ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  #       Restart = "on-failure";
  #       RestartSec = 1;
  #       TimeoutStopSec = 10;
  #     };
  #   };
  # };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
