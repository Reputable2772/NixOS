{
  programs.home-manager.enable = true;

  imports = [
    ./bottom.nix
    ./tmux.nix
  ];
}
