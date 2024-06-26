{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.bash = {
    completion.enable = true;
  };
  programs.zsh = {
    enable = true;
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
