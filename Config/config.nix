/**
  All the config goes here. System config, per-user config, overall flake config, etc.
  The aim is to replace the old config modules.

  If you don't want something, or want to disable the module, set the value to null.

  All the keys are added to ssh-agent using KeePassXC.
*/
rec {
  flake = {
    dir = rec {
      # Internal Variable
      base = "/home/wickedwizard/Documents";
      # Location where undeclarative system config is stored, so that one folder can be moved about systems. This directory needs to be gitignored.
      config = "${self}/Config";
      # Working directory of the flake.nix file
      self = "${base}/NixOS";
    };
  };

  system = {
    secrets = {
      /**
        The SSH Keys for encrypting system related secrets.
        This key should not have password, since age(nix) doesn't support using ssh-agent.
        If you do set a password, it should be entered everytime the system is booted up,
        or everytime you switch configurations.

        Note: If you set a password for this, you most probably cannot use any
        deployment tools like cachix-deploy, colmena, etc.
      */
      encryption = {
        pkeyfile = "${flake.dir.config}/SSH/Encryption/Encryption";
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN618WSaf14crbHvqgDdhAqkgjz6tmyjKwL00viq5CQd wickedwizard@hp-laptop";
      };
    };
  };

  users = {
    wickedwizard = rec {
      # Drives or gocryptfs locations to mount.
      mounts = {
        /**
          By default, authentication for these gocryptfs folders is assumed to be false.
          If authentication is necessary, set `authentication = true` and set `encryptionKeys = [...]`

          When it is set, there needs to be a corresponding age file for the particular key name
          (E.g. important-files key should have `important-files.age` agenix file).
          They need to be stored in this directory only.
          This needs to be done manually, since we cannot use nixpkgs/lib here.
        */
        gocryptfs = {
          important-files = {
            source = "${dir.base}/Important-Files";
            mountpoint = "${dir.base}/../Mounted/Important-Files";
            authentication = true;
          };
        };
      };
      dir = rec {
        # Internal variable, should not be used
        base = "/home/wickedwizard/Documents";
        # Where to store the browser profiles, for easily moving it about.
        browsers = "${base}/Browsers";
        # Where to store generic undeclarative user config. Should be gitignored
        config = "${flake.dir.self}/Config";
        # Where to store all container data. Set to null to disable containers.
        containers = "${base}/Applications/Containers";
      };
      git = {
        # The username and email to set for Git.
        username = "Reputable2722";
        email = "153411261+Reputable2772@users.noreply.github.com";
        secrets = {
          # The SSH Key that is used for authentication by Git
          authentication = {
            pkeyfile = "${users.wickedwizard.dir.config}/SSH/Authentication/Authentication";
            key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBAKg52CA11/TshMFkN689IYepPlIDJZQOA7cMzoe7PU wickedwizard@hp-laptop";
          };
          # The SSH Key that is used for signing by Git
          signing = {
            pkeyfile = "${users.wickedwizard.dir.config}/SSH/Signing/Signing";
            key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB7s075auCly0MMeG91zc20jjzzp4vm0cz0V8SBGNNpR wickedwizard@hp-laptop";
          };
        };
      };
      secrets = {
        # Passwords should not be set for this key, look above.
        encryption = {
          pkeyfile = "${flake.dir.config}/SSH/User-Encryption/User-Encryption";
          key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILsy1bfWG4U17PEZAc4KKVFDxIRtC4fyA8lPCG/f8/ZK wickedwizard@hp-laptop";
        };
      };
      containers = {
        caddy = {
          # Setting it to null or omitting it will use the default directory
          dir = null;
          # A list of all the agenix file names to be used, without the age suffix.
          envFiles = [ "duckdns" "domains" "email" ];
          # Environment variables
          env = [ "LOG_FILE=/data/access.log" ];
        };
        baikal = {
          dir = null;
          envFiles = null;
          env = null;
        };
        qbittorrent = {
          dir = null;
          envFiles = null;
          env = [ "TZ=Asia/Kolkata" "WEBUI_PORT=8516" "PUID=0" "PGID=0" ];
        };
        vaultwarden = {
          dir = null;
          envFiles = [ "push-notifications" ];
          env = [ "WEBSOCKET_ENABLE=true" "ROCKET_PORT=80" "PUSH_ENABLED=true" "LOG_FILE=/data/vaultwarden.log" ];
        };
      };
    };
  };

  # All files should be in the same directory as this file.

  # Agenix config
  "cachix.age".publicKeys = [ system.secrets.encryption.key ];

  # Gocryptfs age files
  "important-files.age".publicKeys = [ users.wickedwizard.secrets.encryption.key ];

  # Container files
  "duckdns.age".publicKeys = [ users.wickedwizard.secrets.encryption.key ];
  "domains.age".publicKeys = [ users.wickedwizard.secrets.encryption.key ];
  "email.age".publicKeys = [ users.wickedwizard.secrets.encryption.key ];
  "push-notifications.age".publicKeys = [ users.wickedwizard.secrets.encryption.key ];
}
