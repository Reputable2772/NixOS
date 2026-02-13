final: prev: {
  prismlauncher-unwrapped = prev.prismlauncher-unwrapped.overrideAttrs (finalAttrs: {
    patches = (prev.patches or [ ]) ++ [ ./prismlauncher.patch ];
  });
}
