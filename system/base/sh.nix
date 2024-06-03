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

  programs.tmux = {
    enable = true;
    newSession = true;
    shortcut = "b";
    keyMode = "vi";
  };

  environment.localBinInPath = true;
  users.defaultUserShell = pkgs.zsh;
}
