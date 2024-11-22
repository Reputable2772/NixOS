{ lib }:
let
  absoluteToRelative =
    _a: _b:
    with lib;
    let
      # Remove trailing '/'
      a = removeSuffix "/" _a;
      b = removeSuffix "/" _b;

      # Split strings at '/' to form a list
      splitA = splitString "/" a;
      splitB = splitString "/" b;

      # Get number of common elements in A and B.
      c = length (lists.commonPrefix splitA splitB);

      # Number of directories to go back from B to reach common directory for A and B.
      backLength = length splitB - c;
      # Get path from common directory.
      forwardPath = drop c splitA;
      path =
        (if backLength < 1 then "./" else "")
        + strings.replicate backLength "../"
        + concatMapStrings (s: s + "/") forwardPath;
    in
    path;
in
absoluteToRelative
