{ pkgs, inputs, ... }: {
  home.packages = with inputs.nix-alien.packages.${pkgs.system}; [
    nix-alien
  ];
}
