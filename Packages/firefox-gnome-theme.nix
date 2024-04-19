{ lib
, stdenv
, fetchFromGitHub
}:
stdenv.mkDerivation rec {
  pname = "firefox-gnome-theme";
  version = "latest";

  src = fetchFromGitHub {
    repo = pname;
    owner = "rafaelmardojai";
    rev = version;
    sha256 = "sha256-QZk/qZQVt1X53peCqB2qmWhpA3xtAVgY95pebSKaTFU=";
  };

  dontConfigure = true;
  dontBuild = true;
  doCheck = false;

  installPhase = ''
    mkdir -p $out/share/firefox-gnome-theme
    cp -r $src/* $out/share/firefox-gnome-theme
  '';

  meta = with lib; {
    description = "A GNOME theme for Firefox";
    homepage = "https://github.com/rafaelmardojai/firefox-gnome-theme";
    license = licenses.unlicense;
  };
}
