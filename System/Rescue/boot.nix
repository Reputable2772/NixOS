{ pkgs, lib, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = lib.mkForce [
      "btrfs"
      "cifs"
      "exfat"
      "ext2"
      "ext4"
      "f2fs"
      "jfs"
      "ntfs"
      "reiserfs"
      "vfat"
      "xfs"
    ];
  };
}
