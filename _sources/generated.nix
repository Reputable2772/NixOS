# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  bottom_catppuccin = {
    pname = "bottom_catppuccin";
    version = "66c540ea512187df5f0c6c97312b0c6da7225af0";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "bottom";
      rev = "66c540ea512187df5f0c6c97312b0c6da7225af0";
      fetchSubmodules = false;
      sha256 = "sha256-Ge2avQXFWEqGPOglJBnH6bjejFGfCyLOqrYcaoAP0XI=";
    };
    date = "2024-05-13";
  };
  dunst_catppuccin = {
    pname = "dunst_catppuccin";
    version = "bfec91a5d0ab02a73a4615243feb5499d376831c";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "dunst";
      rev = "bfec91a5d0ab02a73a4615243feb5499d376831c";
      fetchSubmodules = false;
      sha256 = "sha256-xy99DpBrOKlP7DgKyPgbl4QGC+dnXnvkGlkIG0cmd2A=";
    };
    date = "2024-04-07";
  };
  fastfetch = {
    pname = "fastfetch";
    version = "92abf3e06314ea28ab92a8361669c8492762bf75";
    src = fetchFromGitHub {
      owner = "fastfetch-cli";
      repo = "fastfetch";
      rev = "92abf3e06314ea28ab92a8361669c8492762bf75";
      fetchSubmodules = false;
      sha256 = "sha256-sJrqEFwc69AAnoIHGpvrhiyM2QpyLYyE8nWgV72dpsE=";
    };
    date = "2024-05-18";
  };
  filen = {
    pname = "filen";
    version = "latest";
    src = fetchurl {
      url = "https://cdn.filen.io/desktop/release/filen_x86_64.AppImage";
      sha256 = "sha256-5vkndT9V/81fUdzS+KTfAjPAGO0IJRx8QhNxBNG8nnU=";
    };
  };
  firefox-gnome-theme = {
    pname = "firefox-gnome-theme";
    version = "v126";
    src = fetchFromGitHub {
      owner = "rafaelmardojai";
      repo = "firefox-gnome-theme";
      rev = "v126";
      fetchSubmodules = false;
      sha256 = "sha256-jVbj2JD5GRkP8s3vKBtd9PDpftf3kjLR0ZA/ND/c2+Q=";
    };
  };
  foot_catppuccin = {
    pname = "foot_catppuccin";
    version = "307611230661b7b1787feb7f9d122e851bae97e9";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "foot";
      rev = "307611230661b7b1787feb7f9d122e851bae97e9";
      fetchSubmodules = false;
      sha256 = "sha256-mkPYHDJtfdfDnqLr1YOjaBpn4lCceok36LrnkUkNIE4=";
    };
    date = "2024-05-02";
  };
  nix-fast-build = {
    pname = "nix-fast-build";
    version = "cfff239d93716e92f6467f8953d8f8c12da1892a";
    src = fetchFromGitHub {
      owner = "Mic92";
      repo = "nix-fast-build";
      rev = "cfff239d93716e92f6467f8953d8f8c12da1892a";
      fetchSubmodules = false;
      sha256 = "sha256-wvsg/UMM/jekzgbggH56KLZJzRmwrB9ErevaXXyWyqc=";
    };
    date = "2024-05-15";
  };
  obs_catppuccin = {
    pname = "obs_catppuccin";
    version = "e7c4fcf387415a20cb747121bc0416c4c8ae3362";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "obs";
      rev = "e7c4fcf387415a20cb747121bc0416c4c8ae3362";
      fetchSubmodules = false;
      sha256 = "sha256-dZcgIPMa1AUFXcMPT99YUUhvxHbniv0Anbh9/DB00NY=";
    };
    date = "2024-04-03";
  };
  prismlauncher_catppuccin = {
    pname = "prismlauncher_catppuccin";
    version = "07e9c3ca0ff8eb7da9fa8b5329a9d2ceec707f24";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "prismlauncher";
      rev = "07e9c3ca0ff8eb7da9fa8b5329a9d2ceec707f24";
      fetchSubmodules = false;
      sha256 = "sha256-/qUqF92e3kYkl59GUMMFRtRTzVgSp5tGPxnXLGeusys=";
    };
    date = "2024-03-30";
  };
  rofi-bluetooth = {
    pname = "rofi-bluetooth";
    version = "9d91c048ff129819f4c6e9e48a17bd54343bbffb";
    src = fetchFromGitHub {
      owner = "nickclyde";
      repo = "rofi-bluetooth";
      rev = "9d91c048ff129819f4c6e9e48a17bd54343bbffb";
      fetchSubmodules = false;
      sha256 = "sha256-1Xe3QFThIvJDCUznDP5ZBzwZEMuqmxpDIV+BcVvQDG8=";
    };
    date = "2023-02-03";
  };
  rofi_catppuccin = {
    pname = "rofi_catppuccin";
    version = "5350da41a11814f950c3354f090b90d4674a95ce";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "rofi";
      rev = "5350da41a11814f950c3354f090b90d4674a95ce";
      fetchSubmodules = false;
      sha256 = "sha256-DNorfyl3C4RBclF2KDgwvQQwixpTwSRu7fIvihPN8JY=";
    };
    date = "2022-12-31";
  };
  starship_catppuccin = {
    pname = "starship_catppuccin";
    version = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "starship";
      rev = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
      fetchSubmodules = false;
      sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
    };
    date = "2023-07-13";
  };
}
