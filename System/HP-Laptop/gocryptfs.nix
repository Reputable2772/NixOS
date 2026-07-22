{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ gocryptfs ];

  # Required for PAM to mount FUSE filesystems cleanly
  programs.fuse.userAllowOther = true;

  security.pam.mount.enable = true;
  security.pam.mount.extraVolumes = [
    ""
  ];
}
