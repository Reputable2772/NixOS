{ pkgs, ... }: {
  home.packages = with pkgs; [
    (lutris.override { extraLibraries = pkgs.steam-run.fhsenv.args.multiPkgs; })

    # Fixes NixOS/nixpkgs#285748
    winetricks
  ];
}
