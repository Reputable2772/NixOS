let
  dconf2nix = import ./dconf2nix.nix;
  lutris-unwrapped = import ./lutris-unwrapped.nix;
  prismlauncher-unwrapped = import ./prismlauncher-qt5-unwrapped.nix;
in
[
  dconf2nix
  lutris-unwrapped
  prismlauncher-unwrapped
]
