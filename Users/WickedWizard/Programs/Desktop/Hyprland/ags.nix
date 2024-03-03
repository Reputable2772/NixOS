{ inputs, pkgs, ... }:
{
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  # home.packages = with pkgs; [
  #   asztal
  #   bun
  #   dart-sass
  #   fd
  #   brightnessctl
  #   swww
  #   inputs.matugen.packages.${system}.default
  #   slurp
  #   wf-recorder
  #   wl-clipboard
  #   wayshot
  #   swappy
  #   hyprpicker
  #   pavucontrol
  #   networkmanager
  #   gtk3
  # ];

  programs.ags = {
    enable = false;
    # configDir = null; # if ags dir is managed by home-manager, it'll end up being read-only. not too cool.
    configDir = ./ags;

    extraPackages = with pkgs; [
    ];
  };
}
