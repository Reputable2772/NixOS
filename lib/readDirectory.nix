# Read all the regular files in a directory, and then give an attrset
# containing all files and their paths.
{ lib }:
let
  inherit (lib.attrsets) filterAttrs mapAttrs' nameValuePair;
  inherit (lib.strings) removeSuffix;
in
folder: ext:
lib.pipe (builtins.readDir folder) [
  (filterAttrs (n: v: v == "regular"))
  (mapAttrs' (
    name: path: nameValuePair (if ext then name else removeSuffix ".nix" name) (folder + "/${name}")
  ))
]
