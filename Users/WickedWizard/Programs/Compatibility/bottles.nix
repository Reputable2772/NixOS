{ pkgs, inputs, ... }: {
  # This is needed so that Bottles doesn't use the gamescope provided by nix-community/nixpkgs-wayland
  # and instead uses the one in NixOS/nixpkgs
  home.packages = with pkgs; [
    (bottles.override
      {
        bottles-unwrapped = bottles-unwrapped.override { inherit (inputs.nixpkgs.legacyPackages.${pkgs.system}) gamescope; };
      })
  ];
}
