{
  programs.home-manager.enable = true;

  imports = [
    ./bottom.nix
    ./ip-update.nix
    ./tmux.nix
  ];
}
