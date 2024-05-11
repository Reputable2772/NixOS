# The name is a bit misleading, but what this function essentially does is to read a directory, fetch all the nix files
# and form an attrset with file name as key and value as path to file.
{ lib }:
let
  inherit (lib) attrsets strings;
  recurseDirectory = folder: ext:
    lib.pipe (builtins.readDir folder) [
      (attrsets.filterAttrs (n: v: v == "regular"))
      (attrsets.concatMapAttrs (name: path: {
        ${if ext then name else strings.removeSuffix ".nix" name} = folder + "/${name}";
      }))
    ];
in
recurseDirectory
