# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  arr_scripts = {
    pname = "arr_scripts";
    version = "fd34c3169f29b723623d73f95709fe52cecafeb7";
    src = fetchFromGitHub {
      owner = "RandomNinjaAtk";
      repo = "arr-scripts";
      rev = "fd34c3169f29b723623d73f95709fe52cecafeb7";
      fetchSubmodules = false;
      sha256 = "sha256-4kud7jvzSZqHN/cajP2N2AFDGPjo/L/XpH0oeSNZDRM=";
    };
    date = "2025-02-27";
  };
  bottom_catppuccin = {
    pname = "bottom_catppuccin";
    version = "ed09bd5a5dd78d83acdc8ff5fdec40a6340ed1c2";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "bottom";
      rev = "ed09bd5a5dd78d83acdc8ff5fdec40a6340ed1c2";
      fetchSubmodules = false;
      sha256 = "sha256-Vi438I+YVvoD2xzq2t9hJ9R3a+2TlDdbakjFYFtjtXQ=";
    };
    date = "2024-09-17";
  };
  calibre_catppuccin = {
    pname = "calibre_catppuccin";
    version = "27bd12d2d8dcd24b9ce7cae32135fbd41b896921";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "calibre";
      rev = "27bd12d2d8dcd24b9ce7cae32135fbd41b896921";
      fetchSubmodules = false;
      sha256 = "sha256-JnovYvkIjQXHMFWsmAYIKiA1aexDI3+IkuwwpRdMIcs=";
    };
    date = "2024-09-14";
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
    version = "5955cf0213d14a3494ec63580a81818b6f7caa66";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "dunst";
      rev = "5955cf0213d14a3494ec63580a81818b6f7caa66";
      fetchSubmodules = false;
      sha256 = "sha256-rBp9wU6QHpmNAjeaKnI6u8rOUlv8MC70SLUzeKHN/eY=";
    };
    date = "2024-12-24";
  };
  eza_themes = {
    pname = "eza_themes";
    version = "57149851f07b3ee6ca94f5fe3d9d552f73f8b8b4";
    src = fetchFromGitHub {
      owner = "eza-community";
      repo = "eza-themes";
      rev = "57149851f07b3ee6ca94f5fe3d9d552f73f8b8b4";
      fetchSubmodules = false;
      sha256 = "sha256-vu6QLz0RvPavpD2VED25D2PJlHgQ8Yis+DnL+BPlvHw=";
    };
    date = "2025-02-19";
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
    version = "v135";
    src = fetchFromGitHub {
      owner = "rafaelmardojai";
      repo = "firefox-gnome-theme";
      rev = "v135";
      fetchSubmodules = false;
      sha256 = "sha256-OtF9hFsFXLpCpz5Oy+I7yAE6GgenpFEzUXTc9AtoZQk=";
    };
  };
  foot_catppuccin = {
    pname = "foot_catppuccin";
    version = "962ff1a5b6387bc5419e9788a773a080eea5f1e1";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "foot";
      rev = "962ff1a5b6387bc5419e9788a773a080eea5f1e1";
      fetchSubmodules = false;
      sha256 = "sha256-eVH3BY2fZe0/OjqucM/IZthV8PMsM9XeIijOg8cNE1Y=";
    };
    date = "2024-09-25";
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
    version = "93a1425f906f2e358d764930ab04d13c1c4458d6";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "joplin";
      rev = "93a1425f906f2e358d764930ab04d13c1c4458d6";
      fetchSubmodules = false;
      sha256 = "sha256-gZ4h9/b7FK/jNY0R7+PWgiD2ELqskCFHG2IkTIthkLI=";
    };
    date = "2025-02-27";
  };
  nix-fast-build = {
    pname = "nix-fast-build";
    version = "906af17fcd50c84615a4660d9c08cf89c01cef7d";
    src = fetchFromGitHub {
      owner = "Mic92";
      repo = "nix-fast-build";
      rev = "906af17fcd50c84615a4660d9c08cf89c01cef7d";
      fetchSubmodules = false;
      sha256 = "sha256-HkaJeIFgxncLm8MC1BaWRTkge9b1/+mjPcbzXTRshoM=";
    };
    date = "2025-01-11";
  };
  obs_catppuccin = {
    pname = "obs_catppuccin";
    version = "f8a11f3e53d18c176bea9feb466712a117286a42";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "obs";
      rev = "f8a11f3e53d18c176bea9feb466712a117286a42";
      fetchSubmodules = false;
      sha256 = "sha256-92vB2Mmpj4ir5UWJBqb/EKNLJcZ6ixZakDrFAe2pu9w=";
    };
    date = "2025-02-23";
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
    version = "c24a212a6b07c2d45f32d01d7f10b4d88ddc9f45";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "rofi";
      rev = "c24a212a6b07c2d45f32d01d7f10b4d88ddc9f45";
      fetchSubmodules = false;
      sha256 = "sha256-WGYEA4Q7UvSaRDjP/DiEtfXjvmWbewtdyJWRpjhbZgg=";
    };
    date = "2025-02-20";
  };
  starship_catppuccin = {
    pname = "starship_catppuccin";
    version = "e99ba6b210c0739af2a18094024ca0bdf4bb3225";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "starship";
      rev = "e99ba6b210c0739af2a18094024ca0bdf4bb3225";
      fetchSubmodules = false;
      sha256 = "sha256-1w0TJdQP5lb9jCrCmhPlSexf0PkAlcz8GBDEsRjPRns=";
    };
    date = "2024-12-06";
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
