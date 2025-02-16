{
  config,
  config',
  pkgs,
  lib,
  ...
}:
let
  signFile =
    (pkgs.writeText "signingkey-${config.home.username}" config'.git.secrets.signing.key).outPath;
in
{
  programs.git = {
    enable = true;
    userEmail = config'.git.email;
    userName = config'.git.username;
    signing.signByDefault = lib.mkIf (config'.git.secrets.signing ? key) true;
    signing.key = null;
    signing.format = "ssh";
    extraConfig = {
      core = {
        autocrlf = "input";
      };
      gpg = {
        ssh.allowedSignersFile = signFile;
      };
      user.signingkey = config'.git.secrets.signing.key;
    };
  };

  home.file.ssh_config = {
    enable = true;
    target = ".ssh/ssh_config";
    text = lib.optionals (config'.git.secrets.authentication ? pkeyfile) ''
      Host github.com
        IdentityFile ${config'.git.secrets.authentication.pkeyfile}
    '';
  };
}
