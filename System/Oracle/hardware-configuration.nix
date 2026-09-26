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
    device = "/dev/disk/by-uuid/6F9B-0E15";
    fsType = "vfat";
  };
  boot.initrd.availableKernelModules = [
    "ata_piix"
    "uhci_hcd"
    "xen_blkfront"
    "vmw_pvscsi"
  ];
  boot.initrd.kernelModules = [ "nvme" ];
  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };
  fileSystems."/mnt" = {
    device = "/dev/disk/by-uuid/27a6420a-5f38-4af7-9528-b5902e3224f3";
    fsType = "ext4";
  };

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
}
