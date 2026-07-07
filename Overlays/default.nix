let
  # rtl8821ce = import ./rtl8821ce.nix;
  affine-bin = import ./affine-bin.nix;
  flatpak = import ./flatpak.nix;
  prismlauncher = import ./prismlauncher.nix;
in
[
  # rtl8821ce
  affine-bin
  flatpak
  prismlauncher
]
