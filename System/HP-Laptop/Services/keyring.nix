{
  services.gnome.gnome-keyring.enable = true;

  # Fixes https://github.com/NixOS/nixpkgs/issues/61539#issuecomment-524653963
  environment.sessionVariables = {
    SSH_AUTH_SOCK = "/run/user/$UID/keyring/ssh";
  };
}
