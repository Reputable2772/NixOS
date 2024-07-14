let
  dconf2nix = import ./dconf2nix.nix;
  lutris-unwrapped = import ./lutris-unwrapped.nix;
  # prismlauncher-unwrapped = import ./prismlauncher-unwrapped.nix;
  rtl8821ce = import ./rtl8821ce.nix;
in
[
  dconf2nix
  lutris-unwrapped
  # prismlauncher-unwrapped
  rtl8821ce
]
