# The name is a bit misleading, but what this function essentially does is to read a directory, fetch all the nix files
# and form an attrset with file name as key and value as path to file.
{ lib }:
let
  inherit (lib) attrsets lists strings trivial;
  recurseDirectory = folder:
    lib.pipe (builtins.readDir folder) [
      (attrsets.filterAttrs (n: v: v == "regular"))
      attrsets.attrNames
      (lists.map (str: strings.removeSuffix ".nix" str))
      (trivial.flip attrsets.genAttrs (name: folder + "/${name}.nix"))
    ];
in
recurseDirectory
