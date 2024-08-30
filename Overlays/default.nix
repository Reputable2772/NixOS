let
  dconf2nix = import ./dconf2nix.nix;
  # prismlauncher-unwrapped = import ./prismlauncher-unwrapped.nix;
  rtl8821ce = import ./rtl8821ce.nix;
in
[
  dconf2nix
  # prismlauncher-unwrapped
  rtl8821ce
]
