final: prev: {
  dconf2nix = prev.dconf2nix.overrideAttrs (old: rec {
    src = prev.fetchgit {
      url = "https://github.com/gvolpe/dconf2nix.git";
      sha256 = "sha256-bY3tqV3vt71ReOBNCjijIjALLCOTzVEtWV8fIzz4cBY=";
      rev = "f068c356c40569072eb31b0ae7d81f4ec761d93b";
      fetchSubmodules = true;
    };
  });
}
