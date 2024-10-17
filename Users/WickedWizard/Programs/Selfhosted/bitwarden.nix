{ inputs, pkgs, ... }: {
  # NixOS/nixpkgs#348920
  home.packages = with pkgs; [ inputs.nixpkgs-stable.legacyPackages.${pkgs.system}.bitwarden-desktop bitwarden-cli ];

  # programs.autostart.packages = with pkgs; [ bitwarden ];
}
