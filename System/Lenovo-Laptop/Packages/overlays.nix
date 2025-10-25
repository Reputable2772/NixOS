{ inputs, ... }:
{
  nixpkgs.overlays =
    with inputs;
    [
      nur.overlays.default
      nix4vscode.overlays.default
    ]
    ++ import ../../../Overlays;
}
