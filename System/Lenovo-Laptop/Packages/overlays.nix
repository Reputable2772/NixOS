{ inputs, ... }:
{
  nixpkgs.overlays =
    with inputs;
    [
      nur.overlays.default
    ]
    ++ import ../../../Overlays;
}
