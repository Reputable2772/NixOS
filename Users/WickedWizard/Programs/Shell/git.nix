{ osConfig, config, pkgs, ... }: {
  programs.git = {
    enable = true;
    package = pkgs.git;
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
    };
  };

  home.file.ssh_config = {
    enable = true;
    target = ".ssh/ssh_config";
    text = ''
      Host github.com
        IdentityFile ${osConfig.programs.config_dir.self_dir}/Config/SSH/Git/Authentication/Authentication
    '';
  };
}
