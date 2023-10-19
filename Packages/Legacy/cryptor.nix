{ stdenv
, lib
, meson
, cmake
, vala
, glib
, gtk3
, json-glib
, pkg-config
, ninja
, libgee
, wrapGAppsHook
, fetchFromGitHub
}: stdenv.mkDerivation rec {
  pname = "cryptor";
  version = "1.0.3";

  src = fetchFromGitHub {
    owner = "moson-mo";
    repo = "cryptor";
    rev = "v${version}";
    sha256 = "sha256-bgOOueOKSc6dLyxGU+ds9XYWM5mO+qCKC4dkCu2B1sQ=";
  };

  nativeBuildInputs = [
    meson
    vala
    ninja
    cmake
    pkg-config
    wrapGAppsHook
  ];

  buildInputs = [
    glib
    gtk3
    json-glib
    libgee
  ];

  patches = [
    ./cryptor.patch
  ];

  postBuild = ''
    mkdir -pv $out/share/applications
    cp ../resources/misc/cryptor.desktop $out/share/applications/
  '';

  meta = with lib; {
    description = "Simple GUI application for gocryptfs";
    homepage = "https://github.com/moson-mo/cryptor/";
    license = licenses.bsd3;
    maintainers = [ maintainers.me ];
    platforms = platforms.linux;
  };
}
