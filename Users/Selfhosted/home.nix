{ lib, lib', ... }: {
  programs.home-manager.enable = true;
  programs.quadlets.enable = true;

  imports = [
    ./bottom.nix
    ./ip-update.nix
    ./tmux.nix
  ]
  ++ (lib.attrValues (lib'.readDirectory ./Containers true));
}
