{ inputs, ... }:
{
  nixpkgs.overlays =
    with inputs;
    [
      nur.overlays.default
      hyprpanel.overlay
    ]
    ++ import ../../../Overlays;
}
