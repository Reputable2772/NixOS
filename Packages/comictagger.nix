{
  lib,
  appimageTools,
  fetchurl,
}:

let
  pname = "comictagger";
  version = "1.6.0-beta.10";

  src = fetchurl {
    url = "https://github.com/comictagger/comictagger/releases/download/${version}/ComicTagger-x86_64.AppImage";
    hash = "sha256-ON00/JWuWoWer0zMRmUGC+duPNVUjqxg4+ILeDPloT8=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -Dm644 \
      ${appimageContents}/AppRun.desktop \
      $out/share/applications/comictagger.desktop

    install -Dm644 \
      ${appimageContents}/app.png \
      $out/share/icons/hicolor/256x256/apps/comictagger.png
  '';

  meta = {
    description = "A GUI/CLI application for writing metadata to digital comics";
    homepage = "https://github.com/comictagger/comictagger";
    license = lib.licenses.asl20;
    platforms = [ "x86_64-linux" ];
    mainProgram = "comictagger";
  };
}
