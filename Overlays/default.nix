let
  dconf2nix = import ./dconf2nix.nix;
  flameshot = import ./flameshot.nix;
  lutris-unwrapped = import ./lutris.nix;
  prismlauncher-unwrapped = import ./prismlauncher-qt5-unwrapped.nix;
in
[
  dconf2nix
  flameshot
  lutris-unwrapped
  prismlauncher-unwrapped
]
