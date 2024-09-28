{ pkgs, ... }: {
  home.packages = with pkgs; [
    (lutris.override {
      extraLibraries = steam-run.fhsenv.args.multiPkgs;
      # Fixes NixOS/nixpkgs#285748
      extraPkgs = pkgz: with pkgz; [ winetricks ];
      # Since steam is a flatpak.
      steamSupport = false;
    })
  ];
}
