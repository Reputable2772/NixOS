{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ gocryptfs ];

  # Required for PAM to mount FUSE filesystems cleanly
  programs.fuse.userAllowOther = true;

  security.pam.mount.enable = true;
  security.pam.mount.extraVolumes =
    let
      # This wrapper restores the PATH so gocryptfs can find fusermount
      gocryptfsWrapper = pkgs.writeShellScript "gocryptfs-pam-wrapper" ''
        export PATH="/run/wrappers/bin:/run/current-system/sw/bin:$PATH"
        exec ${pkgs.gocryptfs}/bin/gocryptfs "$@"
      '';
    in
    [
      "<volume user=\"vishnu\" fstype=\"fuse\" path=\"${gocryptfsWrapper}#/home/.vishnu-cipher\" mountpoint=\"/home/vishnu\" options=\"allow_other,quiet,noprealloc,nodev,nosuid\" />"
    ];
}
