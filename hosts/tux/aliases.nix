{
  config,
  lib,
  pkgs,
  ...
}:
let

  aliases = {
    ll = "ls -al";
    rebuild = "sudo nixos-rebuild switch --cores 5";
    upgrade = "nix flake update ~/.config/nixos && sudo nixos-rebuild switch --upgrade --cores 5";
    emacs = "emacs -nw";
    wg-stop = "sudo systemctl stop wg-quick-wg0.service";
    wg-start = "sudo systemctl start wg-quick-wg0.service";
  };
  init = "";
in
{
  programs.bash.shellAliases = aliases;
  programs.bash.shellInit = init;
  programs.zsh.shellAliases = aliases;
  programs.zsh.shellInit = init;
}
