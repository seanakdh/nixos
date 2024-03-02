{ config, lib, pkgs, ... }:
let
  aliases = {
      ll = "ls -al";
      update = "sudo nixos-rebuild switch --cores 5";
      upgrade = "sudo nixos-rebuild switch --upgrade";
  };
  init = "neofetch";
in
{
  programs.bash = {
    shellInit = init;
    shellAliases = aliases;
    enableCompletion = true;
  };
  programs.zsh = {
    shellInit = init;
    enable = true;
    shellAliases = aliases;
    enableCompletion = true;
    enableLsColors = true;
    autosuggestions.enable = true;
    autosuggestions.async = true;
    syntaxHighlighting.enable = true;
    setOptions = [
      "VI"
      "HIST_IGNORE_DUPS"
      "SHARE_HISTORY"
      "HIST_FCNTL_LOCK"
    ];
    histSize = 10000;
    histFile = "~/.zsh_history";
  };
  users.defaultUserShell = pkgs.zsh;
}
