final: prev: {
  prismlauncher-unwrapped = prev.prismlauncher-unwrapped.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      ./prismlauncher-unwrapped.patch
    ];
  });
}
