let
  dconf2nix = import ./dconf2nix.nix;
  prismlauncher = import ./prismlauncher.nix;
  rssguard = import ./rssguard.nix;
in
[ dconf2nix prismlauncher rssguard ]
