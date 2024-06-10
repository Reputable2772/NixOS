{ stdenv
, sources
, librsvg
, fontconfig
}:
stdenv.mkDerivation {
  name = "calibre-catppuccin";
  version = sources.calibre_catppuccin.version;
  src = sources.calibre_catppuccin.src;

  buildPhase = ''
    make XDG_CACHE_HOME=$(mktemp -d) FONTCONFIG_PATH=${fontconfig.out.outPath}/etc/fonts/ convert
  '';

  outputs = [ "latte" "frappe" "macchiato" "mocha" "out" ];

  nativeBuildInputs = [ librsvg ];

  installPhase = ''
    mkdir -p $out

    # Source files are provided as outfiles for theme files.
    cp -r $src $out

    for output in $(getAllOutputNames); do
      if [ "$output" != "out" ]; then
        local outputDir="''${!output}"

        # This ends up in /build/source instead of $src, due to weird input and output dir parsing by upstream.
        mv /build/source/icons/dist/$output $outputDir/
      fi
    done
  '';
}

