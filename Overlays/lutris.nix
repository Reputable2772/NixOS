final: prev: {
  lutris-unwrapped = prev.lutris-unwrapped.overrideAttrs (old: {
    extraLibraries = (prev.extraLibraries or [ ]) ++ [ prev.wine prev.wineWowPackages.stable ];
  });
}
