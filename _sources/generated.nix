# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  arr_scripts = {
    pname = "arr_scripts";
    version = "f7debf4ab7acf189b7e1d8fb1117f9127b5f3daa";
    src = fetchFromGitHub {
      owner = "RandomNinjaAtk";
      repo = "arr-scripts";
      rev = "f7debf4ab7acf189b7e1d8fb1117f9127b5f3daa";
      fetchSubmodules = false;
      sha256 = "sha256-k7OaktGmYcDBOmlwoXM7N6ZoMKfud1Cm/tyuw3/ilBc=";
    };
    date = "2024-06-20";
  };
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
  calibre_catppuccin = {
    pname = "calibre_catppuccin";
    version = "c0cea844e74b6ffb346969839f8548f96fcde14d";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "calibre";
      rev = "c0cea844e74b6ffb346969839f8548f96fcde14d";
      fetchSubmodules = false;
      sha256 = "sha256-/Ipm3V6AJrqugg3Er6u1wriOF8NOmdFdSc2bKRfLvV0=";
    };
    date = "2024-05-10";
  };
  catppuccin_zsh_syntax_highlighting = {
    pname = "catppuccin_zsh_syntax_highlighting";
    version = "06d519c20798f0ebe275fc3a8101841faaeee8ea";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "zsh-syntax-highlighting";
      rev = "06d519c20798f0ebe275fc3a8101841faaeee8ea";
      fetchSubmodules = false;
      sha256 = "sha256-Q7KmwUd9fblprL55W0Sf4g7lRcemnhjh4/v+TacJSfo=";
    };
    date = "2022-10-12";
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
    version = "a6c006221d21d8db370f1e29c1fbd27c65e888bb";
    src = fetchFromGitHub {
      owner = "fastfetch-cli";
      repo = "fastfetch";
      rev = "a6c006221d21d8db370f1e29c1fbd27c65e888bb";
      fetchSubmodules = false;
      sha256 = "sha256-fnYZEI0Nsjo2DWmQGxKs71jX5Lr/yDSUjQlm365yJZs=";
    };
    date = "2024-06-23";
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
    version = "v127";
    src = fetchFromGitHub {
      owner = "rafaelmardojai";
      repo = "firefox-gnome-theme";
      rev = "v127";
      fetchSubmodules = false;
      sha256 = "sha256-ihOVmsno400zgdgSdRRxKRzmKiydH0Vux7LtSDpCyUI=";
    };
  };
  foot_catppuccin = {
    pname = "foot_catppuccin";
    version = "80756a4d63ea4fae4d0fdd793017370f8b8b12ac";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "foot";
      rev = "80756a4d63ea4fae4d0fdd793017370f8b8b12ac";
      fetchSubmodules = false;
      sha256 = "sha256-h6+7ln/i+FRSfWX2aSLhrxFO4mYJgH2pzzhe2Zz9Q4k=";
    };
    date = "2024-06-06";
  };
  hyprland_catppuccin = {
    pname = "hyprland_catppuccin";
    version = "c388ac55563ddeea0afe9df79d4bfff0096b146b";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "hyprland";
      rev = "c388ac55563ddeea0afe9df79d4bfff0096b146b";
      fetchSubmodules = false;
      sha256 = "sha256-xSa/z0Pu+ioZ0gFH9qSo9P94NPkEMovstm1avJ7rvzM=";
    };
    date = "2024-06-19";
  };
  hyprlock_background = {
    pname = "hyprlock_background";
    version = "latest";
    src = fetchurl {
      url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/main/os/nix-black-4k.png";
      sha256 = "sha256-HRZYeKDmfA53kb3fZxuNWvR8cE96tLrqPZhX4+z4lZA=";
    };
  };
  hyprlock_catppuccin = {
    pname = "hyprlock_catppuccin";
    version = "480c46f1f3fa9dd175f8f9611c0d4378324378a7";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "hyprlock";
      rev = "480c46f1f3fa9dd175f8f9611c0d4378324378a7";
      fetchSubmodules = false;
      sha256 = "sha256-Fisxyg5Q5C3dlZdIpgVDEpOUJYrqRMT6HJ+46XUVwI0=";
    };
    date = "2024-06-17";
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
    version = "2edbdf5295bc3c12c3dd53b203ab91028fce2c54";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "prismlauncher";
      rev = "2edbdf5295bc3c12c3dd53b203ab91028fce2c54";
      fetchSubmodules = false;
      sha256 = "sha256-+yGrSZztf2sZ9frPT3ydIJDavo4eXs03cQWfdTAmn3w=";
    };
    date = "2024-06-11";
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
    version = "b636a00fd40a7899a8206195464ae8b7f0450a6d";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "rofi";
      rev = "b636a00fd40a7899a8206195464ae8b7f0450a6d";
      fetchSubmodules = false;
      sha256 = "sha256-zA8Zum19pDTgn0KdQ0gD2kqCOXK4OCHBidFpGwrJOqg=";
    };
    date = "2024-06-20";
  };
  starship_catppuccin = {
    pname = "starship_catppuccin";
    version = "ca2fb0600730fd3958a2cb4d4ca97c401877b365";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "starship";
      rev = "ca2fb0600730fd3958a2cb4d4ca97c401877b365";
      fetchSubmodules = false;
      sha256 = "sha256-KzXO4dqpufxTew064ZLp3zKIXBwbF8Bi+I0Xa63j/lI=";
    };
    date = "2024-05-24";
  };
  wickedwizard_picture = {
    pname = "wickedwizard_picture";
    version = "latest";
    src = fetchurl {
      url = "https://i.pinimg.com/736x/d9/f5/81/d9f58165f05408c80043abebdd62eea5.jpg";
      sha256 = "sha256-lagT6en5bMTeDsUmFFGMiFeg5O21RFUQez2Y0U8QYZU=";
    };
  };
}
