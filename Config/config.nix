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
      base = "/home/wickedwizard/Documents/Coding/Nix";
      # Location where undeclarative system config is stored, so that one folder can be moved about systems. This directory needs to be gitignored.
      config = "${self}/Config";
      # Working directory of the flake.nix file
      self = "${base}/NixOS";
    };
  };

  system = {
    hp-laptop = {
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
    rescue = { };
  };

  users = {
    wickedwizard = rec {
      home = "/home/wickedwizard";
      /**
        There needs to be a corresponding age file, with the name
        `user-backup.age`, use system encryption keys only.
       */
      backup = rec {
        # Internal variables
        base = "${home}/Documents";
        games = "${base}/Games";

        repository = "${base}/Backup";
        paths = {
          include = map (x: "${base}/${x}") [
            "Android"
            "Applications"
            "Books"
            "Browsers"
            "Coding"
            "Config"
            "Games/Linux/Minecraft"
            "Games/Saves"
            "Important-Files"
            "Joplin"
          ];
          exclude = [ ];
        };
        # Ludusavi is a backup tool for Games.
        ludusavi = {
          backup = {
            filter = {
              cloud = {
                epic = false;
                exclude = false;
                gog = false;
                origin = false;
                steam = false;
                uplay = false;
              };
              excludeStoreScreenshots = false;
              ignoredPaths = [ ];
              ignoredRegistry = [ ];
            };
            format = {
              chosen = "zip";
              compression = {
                bzip2.level = 6;
                deflate.level = 6;
                zstd.level = 10;
              };
              zip.compression = "zstd";
            };
            ignoredGames = [ ];
            path = "${games}/Saves";
            retention = {
              differential = 0;
              full = 1;
            };
            sort = {
              key = "name";
              reversed = false;
            };
            toggledPaths = { };
            toggledRegistry = { };
          };
          customGames = [
            {
              files = [
                "${games}/Linux/Half-Life/game/valve/*.cfg"
                "${games}/Linux/Half-Life/game/valve/SAVE"
              ];
              name = "Half-Life";
              registry = [ ];
            }
            {
              files = [
                "${games}/Windows/Half-Life 2/drive_c/Program Files (x86)/DODI-Repacks/Half Life 2/hl2/cfg"
                "${games}/Windows/Half-Life 2/drive_c/Program Files (x86)/DODI-Repacks/Half Life 2/hl2/save"
              ];
              name = "Half-Life 2";
              registry = [ ];
            }
            {
              files = [
                "${games}/Linux/Factorio/*.dat"
                "${games}/Linux/Factorio/config"
                "${games}/Linux/Factorio/saves"
                "${home}/.factorio/config"
                "${home}/.factorio/saves"
              ];
              name = "Factorio";
              registry = [ ];
            }
          ];
          language = "en-US";
          manifest.url = "https://raw.githubusercontent.com/mtkennerly/ludusavi-manifest/master/data/manifest.yaml";
          redirects = [ ];
          restore = {
            ignoredGames = [ ];
            path = "${games}/Saves";
            sort = {
              key = "status";
              reversed = false;
            };
            toggledPaths = { };
            toggledRegistry = { };
          };
          roots = [
            { path = "${home}/.local/share/Steam"; store = "steam"; }
            { path = "${home}/.config/heroic"; store = "heroic"; }
            { path = "${games}/Windows/*"; store = "otherWine"; }
            { path = "${games}/Linux/*"; store = "otherLinux"; }
          ];
          runtime.threads = null;
          scan = {
            showDeselectedGames = true;
            showUnchangedGames = true;
            showUnscannedGames = true;
          };
          theme = "dark";
        };
      };

      # Drives or gocryptfs locations to mount.
      mounts = {
        /**
          By default, authentication for these gocryptfs folders is assumed to be false.
          If authentication is necessary, set `authentication = true` and set `encryptionKeys = [...]`

          When it is set, there needs to be a corresponding age file for the particular key name
          (E.g. important-files key should have `important-files.age` agenix file).
          They need to be stored in this directory only.
          This needs to be done manually, since we cannot use nixpkgs/lib here.

          The mountpoint and all other folders need to be created manually.
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
        base = "${home}/Documents";
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
            pkeyfile = "${users.wickedwizard.dir.config}/SSH/Git/Authentication/Authentication";
            key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBAKg52CA11/TshMFkN689IYepPlIDJZQOA7cMzoe7PU wickedwizard@hp-laptop";
          };
          # The SSH Key that is used for signing by Git
          signing = {
            pkeyfile = "${users.wickedwizard.dir.config}/SSH/Git/Signing/Signing";
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
        gluetun = {
          dir = null;
          # Proton VPN's OpenVPN user and password.
          envFiles = [ "proton-openvpn" ];
          env = [
            "DOT=off"
            "DNS_KEEP_NAMESERVER=on"
            "FREE_ONLY=on"
            "VPN_SERVICE_PROVIDER=protonvpn"
            "SERVER_COUNTRIES=Netherlands"
          ];
        };
        lidarr = {
          dir = null;
          envFiles = [ ];
          env = [ "TZ=Asia/Kolkata" "PUID=0" "PGID=0" ];
        };
        qbittorrent = {
          dir = null;
          envFiles = null;
          env = [ "TZ=Asia/Kolkata" "WEBUI_PORT=8516" "PUID=0" "PGID=0" "TORRENTING_PORT=61851" ];
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
  # We used system encryption key here since the agenix module for the system doesn't have access to the user's agenix keys.
  "wickedwizardPassword.age".publicKeys = [ system.hp-laptop.secrets.encryption.key ];
  "rootPassword.age".publicKeys = [ system.hp-laptop.secrets.encryption.key ];

  # Backup age files
  "wickedwizard-backup.age".publicKeys = [ system.hp-laptop.secrets.encryption.key ];

  # Gocryptfs age files
  "important-files.age".publicKeys = [ users.wickedwizard.secrets.encryption.key ];

  # Container files
  "duckdns.age".publicKeys = [ users.wickedwizard.secrets.encryption.key ];
  "domains.age".publicKeys = [ users.wickedwizard.secrets.encryption.key ];
  "email.age".publicKeys = [ users.wickedwizard.secrets.encryption.key ];
  "push-notifications.age".publicKeys = [ users.wickedwizard.secrets.encryption.key ];
  "proton-openvpn.age".publicKeys = [ users.wickedwizard.secrets.encryption.key ];
}
