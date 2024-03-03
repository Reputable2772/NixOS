{ pkgs
, lib
, appimageTools
, makeDesktopItem
, fetchurl
}:
let
  icon = fetchurl {
    url = "https://filen.io/images/logo_dark.svg";
    sha256 = "sha256-t8Ux+hfH21QPsuDWy9Q9a1aE1INUnQh70ZpwLUx1i+4=";
  };
  description = "Filen provides cheap end-to-end encrypted cloud storage (zero-knowledge principle).";
  desktopItem = (makeDesktopItem {
    name = "Filen";
    exec = "filen-latest %u";
    inherit icon;
    desktopName = "Filen";
    categories = [ "Applications" ];
  });
in
appimageTools.wrapType2 rec {
  pname = "filen";
  version = "latest";

  src = fetchurl {
    url = "https://cdn.filen.io/desktop/release/filen_x86_64.AppImage";
    sha256 = "sha256-5vkndT9V/81fUdzS+KTfAjPAGO0IJRx8QhNxBNG8nnU=";
  };

  extraInstallCommands = ''
    mkdir "$out/share"
    ln -s "${desktopItem}/share/applications" "$out/share/"
  '';

  meta = with lib; {
    inherit description;
    homepage = "https://filen.io/";
    license = licenses.gpl3;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
  };
}
