final: prev: {
  prismlauncher-qt5 = prev.prismlauncher-qt5.overrideAttrs (old: {
    patches = old.patches ++ [
      ./prismlauncher-qt5-crack.patch
    ];
  });
}
