{
  services.gnome-keyring.enable = true;

  # Issues https://github.com/nix-community/home-manager/issues/1600 https://github.com/NixOS/nixpkgs/issues/193835
  home.sessionVariables = {
    SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
  };
}
