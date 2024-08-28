{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.ssh.extraConfig = ''
    Host pve-home
         HostName pve.ohanlon.it
         User root

    Host fw-home
         HostName fw01.ohanlon.it
         User admin

    Host nix-test
         HostName nix-test.ohanlon.it
         User admin

    Host nix-prod
         HostName nix-prod.ohanlon.it
         User admin

     Host github.com
          HostName github.com
          User git

    Host *
         IdentityAgent /run/user/1000/ssh-agent
  '';
}
