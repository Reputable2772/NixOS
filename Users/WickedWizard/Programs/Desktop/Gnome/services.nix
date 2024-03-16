{
  services.gnome-keyring.enable = true;

  home.sessionVariables = {
    SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
  };
}
