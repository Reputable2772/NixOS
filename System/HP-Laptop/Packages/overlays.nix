{ inputs, ... }:
{
  nixpkgs.overlays =
    with inputs;
    [
      nur.overlays.default
      # Configure through HM, somehow.
      hyprpanel.overlay
    ]
    ++ import ../../../Overlays;
}
