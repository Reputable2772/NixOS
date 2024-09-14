# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  arr_scripts = {
    pname = "arr_scripts";
    version = "394c395fa6451771b5b64e7cba6edcea9bee6b9b";
    src = fetchFromGitHub {
      owner = "RandomNinjaAtk";
      repo = "arr-scripts";
      rev = "394c395fa6451771b5b64e7cba6edcea9bee6b9b";
      fetchSubmodules = false;
      sha256 = "sha256-fBUt5SOsOsnNiiLNtgyi7/hOInfTi1a0D7O8cIyg8xM=";
    };
    date = "2024-09-09";
  };
  bottom_catppuccin = {
    pname = "bottom_catppuccin";
    version = "f33104ec5be6cdde0559c2560f85130e48e10cff";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "bottom";
      rev = "f33104ec5be6cdde0559c2560f85130e48e10cff";
      fetchSubmodules = false;
      sha256 = "sha256-Ew2yryQFJRICy3RbtQnLMR5pphXPZp1PtaFVxAL2Eu4=";
    };
    date = "2024-08-09";
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
    version = "7926c3d3e17d26b3779851a2255b95ee650bd928";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "zsh-syntax-highlighting";
      rev = "7926c3d3e17d26b3779851a2255b95ee650bd928";
      fetchSubmodules = false;
      sha256 = "sha256-l6tztApzYpQ2/CiKuLBf8vI2imM6vPJuFdNDSEi7T/o=";
    };
    date = "2024-07-20";
  };
  dunst_catppuccin = {
    pname = "dunst_catppuccin";
    version = "f02cd2894411c9b4caa207cfd8ed6345f97c0455";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "dunst";
      rev = "f02cd2894411c9b4caa207cfd8ed6345f97c0455";
      fetchSubmodules = false;
      sha256 = "sha256-EadNqtF1m//blHkV660+d4YjDReVFU2Bzhs0Pb43jh4=";
    };
    date = "2024-07-20";
  };
  fastfetch = {
    pname = "fastfetch";
    version = "3381062ab9e32bb062732cf6aecf4c1f99b73b4d";
    src = fetchFromGitHub {
      owner = "fastfetch-cli";
      repo = "fastfetch";
      rev = "3381062ab9e32bb062732cf6aecf4c1f99b73b4d";
      fetchSubmodules = false;
      sha256 = "sha256-DrgNYTiOcP8fxm8JNMvuKivzADFVBc2b/IeDjbsPEds=";
    };
    date = "2024-09-14";
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
    version = "v129";
    src = fetchFromGitHub {
      owner = "rafaelmardojai";
      repo = "firefox-gnome-theme";
      rev = "v129";
      fetchSubmodules = false;
      sha256 = "sha256-MOE9NeU2i6Ws1GhGmppMnjOHkNLl2MQMJmGhaMzdoJM=";
    };
  };
  foot_catppuccin = {
    pname = "foot_catppuccin";
    version = "17e2bdc8a8d854e8d390919579f87ab7d5f86e38";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "foot";
      rev = "17e2bdc8a8d854e8d390919579f87ab7d5f86e38";
      fetchSubmodules = false;
      sha256 = "sha256-L5/HvBe4jGTHNSCxFL+xRh8CKYO3NLJ0ksVJIQxjsZA=";
    };
    date = "2024-07-20";
  };
  hyprland_background = {
    pname = "hyprland_background";
    version = "latest";
    src = fetchurl {
      url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nixos-wallpaper-catppuccin-mocha.png";
      sha256 = "sha256-fmKFYw2gYAYFjOv4lr8IkXPtZfE1+88yKQ4vjEcax1s=";
    };
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
    version = "958e70b1cd8799defd16dee070d07f977d4fd76b";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "hyprlock";
      rev = "958e70b1cd8799defd16dee070d07f977d4fd76b";
      fetchSubmodules = false;
      sha256 = "sha256-l4CbAUeb/Tg603QnZ/VWxuGqRBztpHN0HLX/h8ndc5w=";
    };
    date = "2024-08-06";
  };
  joplin_catppuccin = {
    pname = "joplin_catppuccin";
    version = "b0a886ce7ba71b48fdbf72ad27f3446400ebcdb9";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "joplin";
      rev = "b0a886ce7ba71b48fdbf72ad27f3446400ebcdb9";
      fetchSubmodules = false;
      sha256 = "sha256-H19iaemj7XWsd3r7OBvQinrNKMiYGl53ArIp49gZExs=";
    };
    date = "2024-06-21";
  };
  nix-fast-build = {
    pname = "nix-fast-build";
    version = "030e586195c97424844965d2ce680140f6565c02";
    src = fetchFromGitHub {
      owner = "Mic92";
      repo = "nix-fast-build";
      rev = "030e586195c97424844965d2ce680140f6565c02";
      fetchSubmodules = false;
      sha256 = "sha256-8zW6eWvE9T03cMpo/hY8RRZIsSCfs1zmsJOkEZzuYwM=";
    };
    date = "2024-06-27";
  };
  obs_catppuccin = {
    pname = "obs_catppuccin";
    version = "d90002a5315db3a43c39dc52c2a91a99c9330e1f";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "obs";
      rev = "d90002a5315db3a43c39dc52c2a91a99c9330e1f";
      fetchSubmodules = false;
      sha256 = "sha256-rU4WTj+2E/+OblAeK0+nzJhisz2V2/KwHBiJVBRj+LQ=";
    };
    date = "2024-09-14";
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
    version = "3c4749512e7d552adf48e75e5182a271392ab176";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "starship";
      rev = "3c4749512e7d552adf48e75e5182a271392ab176";
      fetchSubmodules = false;
      sha256 = "sha256-t/Hmd2dzBn0AbLUlbL8CBt19/we8spY5nMP0Z+VPMXA=";
    };
    date = "2024-08-16";
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
