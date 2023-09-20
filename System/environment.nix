{ pkgs, ... }: {
  # environment.etc = {
  #   "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
  #     			bluez_monitor.properties = {
  #     				["bluez5.enable-sbc-xq"] = true,
  #     				["bluez5.enable-msbc"] = true,
  #     				["bluez5.enable-hw-volume"] = true,
  #     				["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
  #     			}
  #     		'';
  # };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-music
    geary
    epiphany
    totem
    tali
    iagno
    hitori
    atomix
    simple-scan
  ]);

  environment.systemPackages = with pkgs; [
    git
    curl
    nano
    # libsForQt5.qtstyleplugin-kvantum
    # qt6Packages.qtstyleplugin-kvantum
  ];
}
