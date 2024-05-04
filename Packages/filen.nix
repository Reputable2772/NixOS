# Taken from https://github.com/NixOS/nixpkgs/pull/243693#issuecomment-1957252695 and modified

{ lib
, makeWrapper
, appimageTools
, libappindicator-gtk3
, sources
}:
let
  pname = "filen-desktop";
  version = sources.filen.version;

  src = sources.filen.src;

  appimageContents = appimageTools.extractType2 { inherit pname version src; };

  # Needed for the tray to function
  libPath = lib.makeLibraryPath [ libappindicator-gtk3 ];
in
appimageTools.wrapType2 rec {
  inherit pname version src;

  extraInstallCommands = ''
    source "${makeWrapper}/nix-support/setup-hook"
    wrapProgram $out/bin/${pname} \
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform=wayland --enable-features=WaylandWindowDecorations}}" \
      --prefix LD_LIBRARY_PATH : ${libPath}

    install -m 444 -D ${appimageContents}/${pname}.desktop $out/share/applications/${pname}.desktop
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=filen-desktop'
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';

  meta = with lib; {
    description = "Desktop client for Filen.io";
    homepage = "https://filen.io/";
    license = licenses.agpl3Plus;
    changelog = "https://github.com/FilenCloudDienste/filen-desktop/releases/tag/v${version}";
    platforms = [ "x86_64-linux" ];
  };
}
