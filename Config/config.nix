/**
  All the config goes here. System config, per-user config, overall flake config, etc.
  The aim is to replace the old config modules.

  If you don't want something, or want to disable the module, set the value to null.

  All the keys are added to ssh-agent using KeePassXC.
*/
{
  _home ? { },
}:
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
    timezone = "Asia/Kolkata";
    locale = "en_IN";
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

      mounts = {
        # Need to have a corresponding age file with the object name, if you want to provide authentication.
        bitlocker = {
          windows = {
            source = "/dev/nvme0n1p4";
            mountpoint = "/mnt/Windows";
            authentication = true;
            fsType = "ntfs";
          };
        };
      };
    };
    rescue = { };
  };

  users = {
    wickedwizard = rec {
      home = _home.wickedwizard or "";
      wallpaper = ./wallpaper.jpg;
      /**
        There needs to be a corresponding age file, with the name
        `user-backup.age`, use system encryption keys only.
      */
      backup = rec {
        # Internal variables
        base = "${home}/Documents";

        repository = "${base}/Backup";
        paths = {
          include =
            map (x: "${base}/${x}") [
              "Android"
              # "Applications"
              # "Applications/Containers/Backup"
              "Books"
              "Browsers"
              "Coding"
              "Config"
              "Games/Linux/Minecraft"
              "Games/Saves"
              "Important-Files"
              "Joplin"
            ]
            ++ [
              "/mnt/Windows/Backup"
            ];
          exclude = [ ];
        };
        # Ludusavi is a backup tool for Games.
        ludusavi = import ./ludusavi.nix {
          inherit home;
          games = "${base}/Games";
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
      containers = rec {
        # Not a container, refer to Users/WickedWizard/Programs/Selfhosted/backup.nix.
        # Can contain the path with docker mount path, or without. Doesn't matter.
        backup = {
          blacklistedPaths = [
            lidarr.custom.downloadPath
            lidarr.custom.music.libraryPath
          ] ++ syncthing.custom.folders;
          location = "${dir.base}/Applications/Containers/Backup";
          pwdFile = "containers-backup-pwd";
        };
        caddy = {
          # Setting it to null or omitting it will use the default directory
          dir = null;
          # A list of all the agenix file names to be used, without the age suffix.
          # Content of each agenix file is mentioned below.
          envFiles = [
            "domains"
            "email"
          ];
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
          env = [
            "TZ=${system.timezone}"
            "PUID=0"
            "PGID=0"
          ];
          /**
            Host path to be mounted over to the container
            for copying over downloads from qBittorrent.

            The container path should be same inside
            all the containers.
          */
          custom.downloadPath = qbittorrent.custom.downloadPath;
          custom.music.libraryPath = navidrome.custom.music.libraryPath;
        };
        qbittorrent = {
          dir = null;
          envFiles = null;
          env = [
            "TZ=${system.timezone}"
            "WEBUI_PORT=8516"
            "PUID=0"
            "PGID=0"
            "TORRENTING_PORT=61851"
          ];
          custom.downloadPath = "${dir.base}/Media/Torrents:/data/downloads";
        };
        vaultwarden = {
          dir = null;
          envFiles = [ "push-notifications" ];
          env = [
            "WEBSOCKET_ENABLE=true"
            "ROCKET_PORT=80"
            "PUSH_ENABLED=true"
            "LOG_FILE=/data/vaultwarden.log"
            "EXPERIMENTAL_CLIENT_FEATURE_FLAGS=fido2-vault-credentials,ssh-key-vault-item,ssh-agent"
          ];
        };
        syncthing = {
          dir = null;
          envFiles = null;
          env = [
            "TZ=${system.timezone}"
            "PUID=0"
            "PGID=0"
          ];
          # All custom config that a container requires is put here.
          # Applicable on a per-container basis only.
          custom = {
            # Internal and external mapping of folders for Syncthing
            folders = map (x: dir.base + "/" + x) [
              "Android/Backups:/android-backups"
              "Android/Tasker:/android-tasker"
              "Books:/books"
              "Important-Files:/important-files"
              "Joplin:/joplin"
              "Study-Materials:/study-materials"
            ];
          };
        };
        homepage = {
          dir = null;
          envFiles = null;
          env = null;
        };
        navidrome = {
          dir = null;
          envFiles = null;
          env = [
            "ND_SCANSCHEDULE=1h"
            "ND_LOGLEVEL=info"
            "ND_SESSIONTIMEOUT=24h"
            # Look below.
            "ND_MUSICFOLDER=/data/music"
            # Relative to MusicFolder. So, the location of this folder is /data/music/playlists
            "ND_PLAYLISTSPATH=playlists"
          ];
          custom.music.libraryPath = "${dir.base}/Media/Music:/data/music";
        };
        linkding = {
          dir = null;
          envFiles = null;
          env = null;
        };
        ente_museum = {
          dir = "${dir.containers}/Ente/museum";
          envFiles = [ "ente" ];
          env = [ "ENTE_CREDENTIALS_FILE=/credentials.yaml" ];
        };
        ente_postgres = {
          dir = "${dir.containers}/Ente/postgres";
          envFiles = [ "ente" ];
          env = null;
        };
        # ente_socat = {
        #   dir = "${dir.containers}/Ente/socat";
        #   envFiles = null;
        #   env = null;
        # };
        # ente_minio = {
        #   dir = "${dir.containers}/Ente/minio";
        #   envFiles = [ "ente" ];
        #   env = null;
        # };
        # ente_minio-provision = {
        #   dir = "${dir.containers}/Ente/minio-provision";
        #   env = null;
        #   envFiles = null;
        # };
      };
    };
    guest = { };
  };

  # All files should be in the same directory as this file.

  # Agenix config
  # We used system encryption key here since the agenix module for the system doesn't have access to the user's agenix keys.
  "wickedwizardPassword.age".publicKeys = [ system.hp-laptop.secrets.encryption.key ];
  "rootPassword.age".publicKeys = [ system.hp-laptop.secrets.encryption.key ];
  "guestPassword.age".publicKeys = [ system.hp-laptop.secrets.encryption.key ];

  # Bitlocker age files
  "windows.age".publicKeys = [ system.hp-laptop.secrets.encryption.key ];

  # Backup age files
  "wickedwizard-backup.age".publicKeys = [ system.hp-laptop.secrets.encryption.key ];

  # Gocryptfs age files
  "important-files.age".publicKeys = [ users.wickedwizard.secrets.encryption.key ];

  # Container files
  "containers-backup-pwd.age".publicKeys = [ users.wickedwizard.secrets.encryption.key ];
  "domains.age".publicKeys = [ users.wickedwizard.secrets.encryption.key ];
  "email.age".publicKeys = [ users.wickedwizard.secrets.encryption.key ];
  "push-notifications.age".publicKeys = [ users.wickedwizard.secrets.encryption.key ];
  "proton-openvpn.age".publicKeys = [ users.wickedwizard.secrets.encryption.key ];
  "ente.age".publicKeys = [ users.wickedwizard.secrets.encryption.key ];
}

/**
  wickedwizardPassword.age - Contains the password for user wickedwizard in hashed form.
  rootPassword.age - Contains the password for user root in hashed form.

  windows.age - Contains the Bitlocker recovery key.

  wickedwizard-backup.age - Contains the password for restic backup repository.

  important-files.age - Contains the password for Gocryptfs mount.

  domains.age - Contains DOMAIN and EXTERNAL_DOMAIN and their respective DuckDNS and Cloudflare tokens. (Legacy behaviour, both should be merged into one soon).
  email.age - Contains your email for Caddy, Let's Encrypt
  push-notifications.age - Contains Bitwarden Push Notification keys. (PUSH_INSTALLATION_ID, PUSH_INSTALLATION_KEY). More info - https://github.com/dani-garcia/vaultwarden/wiki/Enabling-Mobile-Client-push-notification
  proton-openvpn.age - Contains the OpenVPN username and password for ProtonVPN. (OPENVPN_USER, OPENVPN_PASSWORD)
  ente.age - Contains POSTGRES_DB, POSTGRES_USER, POSTGRES_PASSWORD, ENTE_DB_NAME, ENTE_DB_USER, ENTE_DB_PASSWORD. They match respectively. (i.e. POSTGRES_DB should have same value as ENTE_DB_NAME)
    Also contains MINIO_ROOT_USER, MINIO_ROOT_PASSWORD.
*/
