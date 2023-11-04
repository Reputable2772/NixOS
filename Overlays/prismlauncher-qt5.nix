final: prev: {
  prismlauncher-qt5-unwrapped = prev.prismlauncher-qt5-unwrapped.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      ./prismlauncher-qt5-crack.patch
    ];
  });
}
