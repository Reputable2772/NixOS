{ config, pkgs, appimageTools, fetchurl }: appimageTools.wrapType1 {
  pname = "filen";
  version = "latest";

  src = fetchurl {
    url = "https://cdn.filen.io/desktop/release/filen_x86_64.AppImage";
    sha256 = "sha256-5vkndT9V/81fUdzS+KTfAjPAGO0IJRx8QhNxBNG8nnU=";
  };

  meta = with lib; {
    description = "Filen provides cheap end-to-end encrypted cloud storage (zero-knowledge principle).";
    homepage = "https://filen.io/";
    license = licenses.gpl3;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
  };
}
