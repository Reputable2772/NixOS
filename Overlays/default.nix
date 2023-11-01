let
  dconf2nix = import ./dconf2nix.nix;
  prismlauncher = import ./prismlauncher.nix;
in
[ dconf2nix prismlauncher ]
