# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  bottom_catppuccin = {
    pname = "bottom_catppuccin";
    version = "c0efe9025f62f618a407999d89b04a231ba99c92";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "bottom";
      rev = "c0efe9025f62f618a407999d89b04a231ba99c92";
      fetchSubmodules = false;
      sha256 = "sha256-VaHX2I/Gn82wJWzybpWNqU3dPi3206xItOlt0iF6VVQ=";
    };
    date = "2022-12-30";
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
    version = "8af88a33763200e62c59eaa82705d6af5977e92c";
    src = fetchFromGitHub {
      owner = "fastfetch-cli";
      repo = "fastfetch";
      rev = "8af88a33763200e62c59eaa82705d6af5977e92c";
      fetchSubmodules = false;
      sha256 = "sha256-xWBxZXf+nSQLisfYLETFA9f88JBiTYeLpdmhgEqQr9E=";
    };
    date = "2024-05-01";
  };
  foot_catppuccin = {
    pname = "foot_catppuccin";
    version = "64ca6fb7a3e1e6867d76d6c0763e0b2d83fc4f01";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "foot";
      rev = "64ca6fb7a3e1e6867d76d6c0763e0b2d83fc4f01";
      fetchSubmodules = false;
      sha256 = "sha256-Sg9R8EKYwK1RYWpeuCYraTk+BoyubHTIUk7IeMLuCw8=";
    };
    date = "2024-04-25";
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