# The name is a bit misleading, but what this function essentially does is to read a directory, fetch all the nix files
# and form an attrset with file name as key and value as path to file.
{ lib }:
let
  inherit (lib.attrsets) filterAttrs mapAttrs' nameValuePair;
  inherit (lib.strings) removeSuffix;
in
folder: ext:
lib.pipe (builtins.readDir folder) [
  (filterAttrs (n: v: v == "regular"))
  (mapAttrs' (name: path: nameValuePair (if ext then name else removeSuffix ".nix" name) (folder + "/${name}")))
]
