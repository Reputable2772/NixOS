{ pkgs }:
let
  iniToNix =
    f:
    let
      iniFile = pkgs.runCommand "convertini" {
        nativeBuildInputs = [ pkgs.jc ];
      } ''jc --ini < ${f} > "$out" '';
    in
    builtins.fromJSON (builtins.readFile iniFile);
in
iniToNix
