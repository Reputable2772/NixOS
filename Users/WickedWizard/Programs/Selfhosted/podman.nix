{ pkgs, ... }: {
  home.packages = with pkgs; [
    podman-compose
    # NixOS/nixpkgs#332957
    # pods
  ];
}
