let
  # rtl8821ce = import ./rtl8821ce.nix;
  affine-bin = import ./affine-bin.nix;
  prismlauncher = import ./prismlauncher.nix;
in
[
  # rtl8821ce
  affine-bin
  prismlauncher
]
