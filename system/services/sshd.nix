{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
  };
  security.pam.sshAgentAuth.enable = true;
}
