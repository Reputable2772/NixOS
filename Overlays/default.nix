let
  auto-cpufreq = import ./auto-cpufreq.nix;
  dconf2nix = import ./dconf2nix.nix;
  # prismlauncher-unwrapped = import ./prismlauncher-unwrapped.nix;
  rtl8821ce = import ./rtl8821ce.nix;
in
[
  auto-cpufreq
  dconf2nix
  # prismlauncher-unwrapped
  rtl8821ce
]
