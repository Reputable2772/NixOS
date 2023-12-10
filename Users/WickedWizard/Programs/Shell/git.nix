{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    libsecret
    lazygit
  ];

  programs.git = {
    enable = true;
    userEmail = "153411261+Reputable2772@users.noreply.github.com";
    userName = "Reputable2722";
    signing = {
      key = "360FB6CAACDE33E0";
      signByDefault = true;
    };
    extraConfig = {
      credential.helper = "/run/current-system/sw/bin/git-credential-libsecret";
    };
  };
}
