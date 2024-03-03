{ ... }: {
  imports = [
    ./chromium.nix
    ./firefox.nix
    ./librewolf.nix
    ./mullvad.nix
    ./tor.nix
  ];
}
