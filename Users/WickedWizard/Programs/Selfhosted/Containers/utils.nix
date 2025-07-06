{
  config,
  config',
  lib,
}:
rec {
  # Appends base part of volume path from config'.
  mapVolume = name: vol: lib.lists.map (v: (getVol name) + v) vol;

  getVol =
    cname:
    (
      if config'.containers.${cname} ? dir && config'.containers.${cname}.dir != null then
        config'.containers.${cname}.dir
      else
        "${config'.dir.containers}/${
          lib.strings.toUpper (lib.strings.substring 0 1 cname)
          + lib.strings.substring 1 (lib.strings.stringLength cname + 1) cname
        }"
    )
    + "/";

  appendEnv = name: {
    Environment = lib.optionals (
      config'.containers.${name} ? env && config'.containers.${name}.env != null
    ) (config'.containers.${name}.env);
    EnvironmentFile = lib.optionals (
      config'.containers.${name} ? envFiles && config'.containers.${name}.envFiles != null
    ) (lib.lists.map (n: config.age.secrets.${n}.path) config'.containers.${name}.envFiles);
  };

  defaults = {
    Service = {
      Restart = "always";
      TimeoutStartSec = 300;
    };
    Unit = {
      Wants = [ "network-online.target" ];
      After = [ "network-online.target" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  containerDefaults =
    name: network:
    lib.recursiveUpdate {
      Container = {
        ContainerName = name;
        PodmanArgs = "--network-alias ${name} --user 0:0";
        Network = network;
      };

      # We convert the raw network name to service name.
      Unit = {
        Requires = [ "${network}-network.service" ];
        After = [ "${network}-network.service" ];
      };
    } defaults;
}
