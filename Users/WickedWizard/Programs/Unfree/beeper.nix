{ pkgs, inputs, ... }:
let
  nixpkgs-unfree = inputs.nixpkgs-unfree.legacyPackages.${pkgs.system};
in
{
  home.packages = with nixpkgs-unfree; [ beeper ];

  programs.autostart.autostartPackages = with nixpkgs-unfree; [ beeper ];
}
