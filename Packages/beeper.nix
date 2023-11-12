# Taken from https://git.midna.dev/mjm/nix-config/-/blob/main/packages/beeper.nix

{ appimageTools
, lib
, fetchurl
, makeWrapper
, writeShellScript
, curl
, gnugrep
, pcre
, common-updater-scripts
,
}:
appimageTools.wrapType2 rec {
  pname = "beeper";
  version = "latest";

  src = fetchurl {
    url = "https://download.beeper.com/linux/appImage/x64";
    sha256 = "sha256-sYdfN535Fg3Bm26XKQNyuTItV+1dT3W/2HGH51ncEM0=";
  };

  extraPkgs = pkgs:
    with pkgs; [
      libsecret
    ];

  extraInstallCommands =
    let
      contents = appimageTools.extractType2 { inherit pname version src; };
    in
    ''
      source ${makeWrapper}/nix-support/setup-hook
      mv $out/bin/${pname}-${version} $out/bin/${pname}
      wrapProgram $out/bin/${pname} \
        --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform=wayland}}"

      install -m 444 -D ${contents}/beeper.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/beeper.desktop \
        --replace 'Exec=AppRun' 'Exec=${pname}'
      cp -r ${contents}/usr/share/icons $out/share
    '';

  passthru = {
    updateScript = writeShellScript "update-beeper" ''
      set -o errexit
      set -x
      export PATH="${lib.makeBinPath [curl gnugrep pcre common-updater-scripts]}"
      version="$(curl -sI -X GET https://download.beeper.com/linux/appImage/x64 | grep -Fi 'content-disposition:' | pcregrep -o1 'beeper-(([0-9]\.?)+[0-9])')"
      update-source-version beeper "$version"
    '';
  };

  meta = with lib; {
    description = "All your chats in one app.";
    homepage = "https://beeper.com";
    license = licenses.unfree;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
  };
}
