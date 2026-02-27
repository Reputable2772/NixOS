{
  home ? "",
  games ? "",
}:
{
  release.check = true;
  manifest.enable = true;
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
      zip.compression = "deflate";
    };
    ignoredGames = [ ];
    path = "${games}/Saves";
    retention = {
      differential = 1;
      full = 3;
    };
    sort = {
      key = "status";
      reversed = false;
    };
    toggledPaths = { };
    toggledRegistry = { };
    onlyConstructive = false;
  };
  customGames = [ ];
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
    reverseRedirects = false;
  };
  roots = [
    {
      path = "${home}/.var/app/com.valvesoftware.Steam/.local/share/Steam";
      store = "steam";
    }
    {
      path = "${home}/.var/app/com.heroicgameslauncher.hgl/config/heroic";
      store = "heroic";
    }
    {
      database = "${home}/.var/app/net.lutris.Lutris/data/lutris/pga.db";
      path = "${home}/.var/app/net.lutris.Lutris/data/lutris";
      store = "lutris";
    }
  ];
  runtime.threads = null;
  scan = {
    showDeselectedGames = true;
    showUnchangedGames = true;
    showUnscannedGames = true;
  };
  theme = "dark";
  cloud = {
    remote = null;
    path = "ludusavi-backup";
    synchronize = true;
  };
  apps = { };
}
