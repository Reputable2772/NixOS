{ config, pkgs, ... }:
let
  # Fixes https://github.com/NixOS/nixpkgs/issues/292700
  _flameshot =
    if (!config.programs.gnome.enable)
    then
      pkgs.flameshot.overrideAttrs
        (oldAttrs: {
          src = pkgs.fetchFromGitHub {
            owner = "flameshot-org";
            repo = "flameshot";
            rev = "3d21e4967b68e9ce80fb2238857aa1bf12c7b905";
            sha256 = "sha256-OLRtF/yjHDN+sIbgilBZ6sBZ3FO6K533kFC1L2peugc=";
          };
          cmakeFlags = [
            "-DUSE_WAYLAND_CLIPBOARD=1"
            "-DUSE_WAYLAND_GRIM=1"
          ];
          buildInputs = oldAttrs.buildInputs ++ [ pkgs.libsForQt5.kguiaddons ];
        })
    else
      pkgs.flameshot;
in
{
  home.packages = with pkgs; [
    tesseract

    # Flameshot doesn't detect them otherwise
    wl-clipboard
    grim
  ] ++ [ _flameshot ];

  services.flameshot = {
    enable = true;
    package = _flameshot;
    settings = {
      General = {
        autoCloseIdleDaemon = true;
        contrastOpacity = 188;
        copyOnDoubleClick = true;
        copyPathAfterSave = false;
        saveAfterCopy = true;
        undoLimit = 100;
        uploadWithoutConfirmation = true;
      };
      Shortcuts = {
        TYPE_IMAGEUPLOADER = "Ctrl+V";
      };
    };
  };
}
