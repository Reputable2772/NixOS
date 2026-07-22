{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.fscrypt-experimental ];
  security.pam.enableFscrypt = true;
}
