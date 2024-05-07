# The name is a bit misleading, but what this function essentially does is to read a directory, fetch all the nix files
# and form an attrset with file name as key and value as path to file.
{ lib }:
let
  inherit (lib) attrsets lists strings;
  recurseDirectory = folder: attrsets.genAttrs
    (lists.forEach
      (attrsets.attrNames (attrsets.filterAttrs (name: value: value == "regular") (builtins.readDir folder)))
      (str: strings.removeSuffix ".nix" str))
    (name: folder + "/${name}.nix");
in
recurseDirectory
