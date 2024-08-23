{ config, pkgs, inputs, lib, ... }:
let
  inherit (lib.attrsets) mapAttrsToList;
  inherit (lib.lists) flatten;
in
{
  programs.nix-ld = {
    enable = true;
    package = inputs.nix-ld-rs.packages.${pkgs.system}.nix-ld-rs;

    libraries =
      if config ? home-manager then
      # All packages installed by any user that has HM.
        flatten (mapAttrsToList (n: v: v.home.packages) config.home-manager.users)
      else
      # Taken from https://github.com/Mic92/dotfiles/blob/main/nixos/modules/nix-ld.nix
        with pkgs; [
          alsa-lib
          at-spi2-atk
          at-spi2-core
          atk
          cairo
          cups
          curl
          dbus
          expat
          fontconfig
          freetype
          fuse3
          gdk-pixbuf
          glib
          gtk3
          icu
          libGL
          libappindicator-gtk3
          libdrm
          libglvnd
          libnotify
          libpulseaudio
          libunwind
          libusb1
          libuuid
          libxkbcommon
          libxml2
          mesa
          nspr
          nss
          openssl
          pango
          pipewire
          stdenv.cc.cc
          systemd
          vulkan-loader
          xorg.libX11
          xorg.libXScrnSaver
          xorg.libXcomposite
          xorg.libXcursor
          xorg.libXdamage
          xorg.libXext
          xorg.libXfixes
          xorg.libXi
          xorg.libXrandr
          xorg.libXrender
          xorg.libXtst
          xorg.libxcb
          xorg.libxkbfile
          xorg.libxshmfence
          zlib
        ];
  };
}
