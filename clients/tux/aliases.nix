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
    rebuild-nc = "nixos-rebuild --target-host nc-home --use-remote-sudo switch --flake ~/.config/nixos#nc --cores 5";
    upgrade = "nix flake update ~/.config/nixos && sudo nixos-rebuild switch --upgrade --cores 5";
    wg-stop = "sudo systemctl stop wg-quick-wg0.service";
    wg-start = "sudo systemctl start wg-quick-wg0.service";
    rust-docs = "xdg-open $(nix build fenix#stable.rust-docs --json --no-link | jq '.[0].outputs.out' -r)/share/doc/rust/html/index.html";
  };
  init = "";
in
{
  programs.bash.shellAliases = aliases;
  programs.bash.shellInit = init;
  programs.zsh.shellAliases = aliases;
  programs.zsh.shellInit = init;
}
