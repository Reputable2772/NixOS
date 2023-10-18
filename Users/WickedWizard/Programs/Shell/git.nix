{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    libsecret
    lazygit
  ];

  programs.git = {
    enable = true;
    userEmail = "coding.exhibiting@slmails.com";
    userName = "WickedWizard3588";
    signing = {
      key = "360FB6CAACDE33E0";
      signByDefault = true;
    };
    extraConfig = {
      credential.helper = "/run/current-system/sw/bin/git-credential-libsecret";
    };
  };
}
