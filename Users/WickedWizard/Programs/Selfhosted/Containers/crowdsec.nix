{
  config,
  pkgs,
  lib,
  ...
}:
let
  yaml = pkgs.formats.yaml { };

  inherit (lib) types;
  inherit (lib.options) mkOption;

  cfg = config.containers.crowdsec;

  journaldConfig = {
    source = "journalctl";
    journalctl_filter = [
      "--boot"
      "--directory=/var/log/host/"
    ];
    labels.type = "syslog";
  };
in
{
  options.containers.crowdsec = {
    bouncers = mkOption {
      description = "Custom bouncers to add to Crowdsec. NOTE: API Keys need to be created and used manually";
      default = { };
      type = types.attrsOf yaml.type;
    };

    collections = mkOption {
      description = "Extra collections that need to be added to crowdsec.";
      default = [ ];
      type = types.listOf types.str;
    };
  };

  config = {
    /**
      This container in its current state, is not exactly declarative.

      Sure, the log parsers are, but
      Bouncers aren't. For example, on Lenovo-Laptop, the Firewall
      Bouncer relies on an API Key obtained using `cscli bouncer add <name>`,
      manually stored in an age file. (Applicable to all bouncers added
      using this module.)

      Generic default config is available here
      https://github.com/crowdsecurity/crowdsec/tree/master/config
    */

    programs.quadlets.quadlets."crowdsec.container" = {
      Container = {
        ContainerName = "crowdsec";
        Image = "docker.io/crowdsecurity/crowdsec:latest-debian";
        PublishPort = [ "127.0.0.1:8008:8080" ];
        Network = "systemd-caddy.network";
        Environment = [
          "GID=0"
          "UID=0"
          "COLLECTIONS=\"crowdsecurity/linux crowdsecurity/iptables ${lib.concatStringsSep " " cfg.collections}\""
        ];
        /**
          This is because, in podman rootless, mounting /var/log/journal
          means that the container user can only read host user logs, not
          host system logs, even though the host user can read host system
          logs.

          Solution found here:
          https://github.com/podman-container-tools/podman/discussions/26693
        */
        GroupAdd = "keep-groups";
        Volume = [
          "${yaml.generate "journald.yaml" journaldConfig}:/etc/crowdsec/acquis.d/journald.yaml:noMap"
          "/var/log/journal:/var/log/host:ro:noMap"
          # This mount is meant for multiple containers to use and feed to this container.
          "crowdsec-logs.volume:/logs"
          "data:/var/lib/crowdsec/data"
          "config:/etc/crowdsec"
        ]
        ++ (lib.mapAttrsToList (
          fname: val: "${yaml.generate fname val}:/etc/crowdsec/acquis.d/${fname}:noMap"
        ) cfg.bouncers);
      };
    };

    programs.quadlets.quadlets."crowdsec-logs.volume".Volume.VolumeName = "crowdsec-logs";
  };
}
