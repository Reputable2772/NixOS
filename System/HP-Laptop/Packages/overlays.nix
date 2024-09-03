{ inputs, ... }: {
  nixpkgs.overlays = with inputs; [
    nur.overlay
  ] ++ import ../../../Overlays;
}
