{ modulesPath, ... }:
{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];
  boot.loader = {
    efi.efiSysMountPoint = "/boot/efi";
    grub = {
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
    };
  };
  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/2A86-5B75";
    fsType = "vfat";
  };
  boot.initrd.availableKernelModules = [
    "ata_piix"
    "uhci_hcd"
    "xen_blkfront"
  ];
  boot.initrd.kernelModules = [ "nvme" ];
  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };
  fileSystems."/mnt" = {
    device = "/dev/disk/by-uuid/d563b8d8-11c4-405b-b726-8a61e9a15d7f";
    fsType = "ext4";
  };

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
}
