{ pkgs, inputs, ... }: {
  programs.steam = {
    enable = false;
    package = inputs.nixpkgs-unfree.legacyPackages.${pkgs.system}.steam;
  };

  # environment.systemPackages = [ inputs.nixpkgs-unfree.legacyPackages.${pkgs.system}.steam ];
}
