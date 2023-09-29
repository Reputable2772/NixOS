{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    libsecret
    lazygit
  ];

  # services.gnome.gnome-online-accounts.enable = lib.mkForce false;
  # services.gnome.gnome-keyring.enable = lib.mkForce false;
  # programs.seahorse.enable = lib.mkForce false;

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
