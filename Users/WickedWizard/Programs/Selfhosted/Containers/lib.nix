{ config', lib, ... }:
let
  inherit (lib.attrsets) concatMapAttrs filterAttrs genAttrs;
in
{
  programs.quadlets.enable =
    config'.dir ? containers && lib.strings.typeOf config'.dir.containers == "string";
  programs.quadlets.mkdir = true;

  age.secrets = lib.pipe config'.containers [
    (filterAttrs (n: v: v ? envFiles && v.envFiles != null))
    (concatMapAttrs (
      n: v:
      genAttrs v.envFiles (f: {
        file = ./. + "../../../../../../Config/${f}.age";
      })
    ))
  ];
}
