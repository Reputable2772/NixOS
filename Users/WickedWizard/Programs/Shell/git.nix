{ config, config', pkgs, lib, ... }:
let
  signFile = builtins.toString (pkgs.writeText "signingkey-${config.home.username}" config'.secrets.git.signing.key);
in
{
  programs.git = {
    enable = true;
    package = pkgs.git;
    userEmail = config'.config.git.email;
    userName = config'.config.git.username;
    signing.signByDefault = lib.mkIf
      (lib.attrsets.hasAttrByPath [ "git" "signing" "key" ] config'.secrets)
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
      user.signingkey = config'.secrets.git.signing.key;
    };
  };

  home.file.ssh_config = {
    enable = true;
    target = ".ssh/ssh_config";
    text =
      lib.optionals
        (lib.attrsets.hasAttrByPath [ "git" "authentication" "pkeyfile" ] config'.secrets)
        ''
          Host github.com
            IdentityFile ${config'.secrets.git.authentication.pkeyfile}'';
  };
}
