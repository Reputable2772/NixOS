{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    (lutris.override {
      extraLibraries = pkgs: [
        wine
        wineWowPackages.stable
      ];
    })
  ];
}
