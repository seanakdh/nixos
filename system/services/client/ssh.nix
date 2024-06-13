{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.ssh.extraConfig = ''
    Host pve-home
         HostName pve.ohanlon-it.net
         User root

    Host fw-home
         HostName fw01.ohanlon-it.net
         User admin

    Host nc-home
         HostName nc.ohanlon-it.net
         User admin

    Host *
         IdentityAgent /run/user/1000/ssh-agent
  '';
}
