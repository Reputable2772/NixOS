{ config, config', pkgs, lib, ... }:
let
  userConfig = config'.users.${config.home.username};
  signFile = builtins.toString (pkgs.writeText "signingkey-${config.home.username}" userConfig.secrets.git.signing.key);
in
{
  programs.git = {
    enable = true;
    package = pkgs.git;
    userEmail = userConfig.config.git.email;
    userName = userConfig.config.git.username;
    signing.signByDefault = lib.mkIf
      (lib.attrsets.hasAttrByPath [ "git" "signing" "key" ] userConfig.secrets)
      true;
    signing.key = null;
    extraConfig = {
      core = {
        autocrlf = "input";
      };
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = signFile;
      };
      user.signingkey = userConfig.secrets.git.signing.key;
    };
  };

  home.file.ssh_config = {
    enable = true;
    target = ".ssh/ssh_config";
    text =
      lib.optionals
        (lib.attrsets.hasAttrByPath [ "git" "authentication" "pkeyfile" ] userConfig.secrets)
        ''
          Host github.com
            IdentityFile ${userConfig.secrets.git.authentication.pkeyfile}'';
  };
}
