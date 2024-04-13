{ osConfig, pkgs, ... }: {
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
        ssh.allowedSignersFile = "${osConfig.programs.config_dir.config_dir}/Git/allowed_signers";
      };
      user.signingkey = "${osConfig.programs.config_dir.config_dir}/SSH/Git.pub";
      credential.helper = "libsecret";
    };
  };
}
