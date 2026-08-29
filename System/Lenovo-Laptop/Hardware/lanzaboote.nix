{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
let
  bootMountPoint = config.boot.loader.efi.efiSysMountPoint;

  memtest = pkgs.memtest86plus.efi;
  memtestPath = "/${bootMountPoint}/EFI/memtest86/memtest.efi";
in
{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  nix.settings = {
    substituters = [ "https://lanzaboote.cachix.org?priority=40" ];
    trusted-public-keys = [ "lanzaboote.cachix.org-1:Nt9//zGmqkg1k5iu+B3bkj3OmHKjSw9pvf3faffLLNk=" ];
  };

  boot.loader.systemd-boot.enable = lib.mkForce (!config.boot.lanzaboote.enable);
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    settings.editor = true;
  };

  systemd.services.sign-memtest86 = {
    description = "Sign memtest86 EFI binary for Secure Boot (Lanzaboote)";
    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" ];
    serviceConfig.Type = "oneshot";
    path = [ pkgs.sbctl ];
    script = ''
      mkdir -p ${bootMountPoint}/EFI/memtest86
      install -m 0644 ${memtest} ${memtestPath}
      sbctl sign ${memtestPath}

      mkdir -p ${bootMountPoint}/loader/entries
      cat > ${bootMountPoint}/loader/entries/memtest86.conf <<'EOF'
        title   Memtest86+
        efi     /efi/memtest86/memtest.efi
      EOF
    '';
  };
}
