let
  dconf2nix = import ./dconf2nix.nix;
  prismlauncher-qt5 = import ./prismlauncher-qt5.nix;
in
[ dconf2nix prismlauncher-qt5 ]
