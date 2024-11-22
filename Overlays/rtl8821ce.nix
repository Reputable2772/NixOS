final: prev:
let
  inherit (prev) lib linuxKernel;
  inherit (lib.attrsets) filterAttrs mapAttrs;
  inherit (lib.strings) hasPrefix;
  inherit (lib.trivial) pipe;
in
{
  linuxKernel = linuxKernel // {
    packages =
      linuxKernel.packages
      // (pipe linuxKernel.packages [
        # Get every attrName that begins with linux and doesn't throw an error for value
        (filterAttrs (n: v: hasPrefix "linux" n && (builtins.tryEval v).success))
        (mapAttrs (
          n: v:
          v
          // {
            rtl8821ce = linuxKernel.packages.${n}.rtl8821ce.overrideAttrs {
              src = prev.fetchFromGitHub {
                owner = "tomaspinho";
                repo = "rtl8821ce";
                rev = "f119398d868b1a3395f40c1df2e08b57b2c882cd";
                hash = "sha256-EfpKa5ZRBVM5T8EVim3cVX1PP1UM9CyG6tN5Br8zYww=";
              };
            };
          }
        ))
      ]);
  };
}
