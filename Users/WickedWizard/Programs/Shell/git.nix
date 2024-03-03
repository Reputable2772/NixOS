{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userEmail = "153411261+Reputable2772@users.noreply.github.com";
    userName = "Reputable2722";
    signing.signByDefault = true;
    signing.key = null;
    extraConfig = {
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "${config.home.homeDirectory}/Documents/Config/Git/allowed_signers";
      };
      user.signingkey = "${config.home.homeDirectory}/Documents/Config/SSH/Git.pub";
      credential.helper = "libsecret";
    };
  };
}
