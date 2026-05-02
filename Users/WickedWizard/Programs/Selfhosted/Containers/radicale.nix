{
  config,
  pkgs,
  lib,
  sources,
  ...
}:
let
  userFilePath = "/config/users";

  # birthdayHookSh file calls birthdayHook later.
  birthdayHookSh = "/create_birthday_hook.sh";

  # Taken from https://github.com/iBigQ/radicale-birthday-calendar/issues/6#issuecomment-3797883142
  # and modified to use python binary from venv and use find instead of grep from busybox
  birthdayHookShFile = pkgs.writeTextFile {
    name = "create_birthday_hook.sh";
    executable = true;
    text = ''
      #!/bin/sh

      # The python script requires us to CD to
      # the parent directory of collection-root
      # to work correctly
      cd /data/

      # Log for debugging (remove once working)
      exec >> /data/birthday_hook 2>&1
      echo "=== Hook triggered at $(date) ==="
      echo "PWD: $(pwd)"
      echo "PATH: $PATH"

      # Find all .vcf files with BDAY field and format paths correctly
      find collection-root \
        -type d -name '.*' -prune -o \
        -type f -name "*.vcf" -print0 | \
        xargs -0 grep -l "^BDAY:" 2>/dev/null | \
      /venv/bin/python3 "${birthdayHook}"

      echo "=== Hook completed ==="
    '';
    checkPhase = ''
      ${pkgs.stdenv.shellDryRun} "$target"
    '';
  };

  birthdayHook = "/create_birthday_calendar.py";

  radicaleConfig = lib.generators.toINI { } {
    auth = {
      type = "htpasswd";
      htpasswd_filename = userFilePath;
      htpasswd_encryption = "autodetect";
    };
    storage = {
      filesystem_folder = "/data";
      hook = birthdayHookSh;
    };

    server.hosts = "0.0.0.0:5232, [::]:5232";
  };
in
{
  containers.caddy.services.radicale = "radicale:5232";

  # Mounted directly as a file, not an environment variable.
  age.secrets.radicale.file = ../../../../../Config/radicale.age;

  programs.quadlets.quadlets."radicale.container" = {
    Container = {
      Image = "docker.io/tomsquest/docker-radicale";
      ContainerName = "radicale";
      Network = "systemd-caddy.network";
      AddCapability = [
        "CHOWN"
        "SETUID"
        "SETGID"
        "KILL"
      ];
      DropCapability = "ALL";
      NoNewPrivileges = true;
      RunInit = true;
      Label = [ "wud.watch.digest=true" ];

      # Radicale tries to drop privileges inside the container,
      # meaning that it cannot read the mounted /config/users file.
      # Forcing it to run as root inside the container means that it has
      # the same permissions as the outer user, so it can read
      # the mounted agenix file.
      Environment = [
        "UID=0"
        "GID=0"
      ];

      Volume = [
        "data:/data"
        "${pkgs.writeText "radicale-config" radicaleConfig}:/config/config:ro:noMap"
        "${config.age.secrets.radicale.path}:${userFilePath}:noMap"
        "${birthdayHookShFile}:${birthdayHookSh}:noMap"
        "${sources.radicale_birthday_hook.src}${birthdayHook}:${birthdayHook}:noMap"
      ];

      HealthCmd = "curl --fail http://127.0.0.1:5232 || exit 1";
      HealthInterval = "30s";
      HealthRetries = 3;
    };
  };
}
