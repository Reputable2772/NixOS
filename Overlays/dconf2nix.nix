final: prev: {
  dconf2nix = prev.dconf2nix.overrideAttrs (old: {
    src = prev.fetchgit {
      url = "https://github.com/gvolpe/dconf2nix.git";
      sha256 = "sha256-/zVlBPSdH1sAi6XcKfSlK8DUSjDAHrPW3I9knw+2ODs=";
      rev = "2fc3b0dfbbce9f1ea2ee89f3689a7cb95b33b63f";
      fetchSubmodules = true;
    };
  });
}
