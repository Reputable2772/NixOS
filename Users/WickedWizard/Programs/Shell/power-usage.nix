{
  osConfig,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    ttyplot
    osConfig.boot.kernelPackages.turbostat
    (writeShellScriptBin "power-graph" ''
      sudo test
      sudo ${osConfig.boot.kernelPackages.turbostat}/bin/turbostat --Summary --quiet --show PkgWatt --interval 1 | ${lib.getExe gawk} '{ printf("%.2f\n" , $1); fflush(); }' | ${ttyplot} -s 100 -t "Turbostat - CPU Power (watts)" -u "watts"
    '')
  ];
}
