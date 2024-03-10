let
  dconf2nix = import ./dconf2nix.nix;
  flameshot = import ./flameshot.nix;
  prismlauncher-qt5 = import ./prismlauncher-qt5.nix;
in
[
  dconf2nix
  flameshot
  prismlauncher-qt5
]
