{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userEmail = "153411261+Reputable2772@users.noreply.github.com";
    userName = "Reputable2722";
    signing.signByDefault = true;
    signing.key = null;
    extraConfig = {
      core = {
        autocrlf = "input";
      };
      gpg = {
        format = "ssh";
      };
      user.signingkey = builtins.toString (pkgs.writeText "signingkey-${config.home.username}" config.programs.secrets.secrets.git.signing);
      credential.helper = "libsecret";
    };
  };
}
