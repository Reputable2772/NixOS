final: prev: {
  rssguard = prev.rssguard.overrideAttrs (old: rec {
  pname = "rssguard";
  version = "4.5.1";

  src = prev.fetchFromGitHub {
    owner = "martinrotter";
    repo = pname;
    rev = version;
    sha256 = "sha256-1xoMymsx5Z8oZzZtPzLWaOs0zy/E0pIsLpHgZlVdgSw=";
  };

  });
}
