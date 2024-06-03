{
  config,
  lib,
  pkgs,
  ...
}:

{
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  environment.systemPackages = with pkgs; [
    libGL
    libGLU
  ];
  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  }; # Force intel-media-driver
  boot.kernelParams = [ "iHD.force_probe=46a6" ];
}
