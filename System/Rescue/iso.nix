{ inputs, ... }: {
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-base.nix"
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"
  ];

  isoImage.isoBaseName = "rescue";

  networking.hostName = "rescue";
}
