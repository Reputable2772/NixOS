{
  lib,
  stdenv,
  sources,
}:
stdenv.mkDerivation {
  pname = "firefox-gnome-theme";
  version = sources.firefox-gnome-theme.version;

  src = sources.firefox-gnome-theme.src;

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
