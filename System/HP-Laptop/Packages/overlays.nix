{ inputs, ... }: {
  nixpkgs.overlays = with inputs; [
    nur.overlay
    nixpkgs-wayland.overlay
  ] ++ import ../../../Overlays;
}
