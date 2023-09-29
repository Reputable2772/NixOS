final: prev: {
  prismlauncher-qt5-unwrapped = prev.prismlauncher-qt5-unwrapped.overrideAttrs (old: {
    patches = [ ] ++ [
      ../WickedWizard/Programs/Games/crack.patch
    ];
  });
}
