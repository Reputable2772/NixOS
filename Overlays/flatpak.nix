# Fixes flatpak/flatpak#6717

(final: prev: {
  flatpak = prev.flatpak.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      wrapProgram $out/bin/flatpak \
        --suffix PATH : /usr/bin:/bin
    '';
  });
})
