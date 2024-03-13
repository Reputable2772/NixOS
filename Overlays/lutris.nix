final: prev: {
  lutris-unwrapped = prev.lutris-unwrapped.overrideAttrs (old: rec {
    extraLibraries = (prev.extraLibraries or []) ++ [ prev.wine prev.wineWowPackages.stable ];
  });
}
