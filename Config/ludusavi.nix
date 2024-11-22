{
  home ? "",
  games ? "",
}:
{
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
  };
  roots = [
    {
      path = "${home}/.local/share/Steam";
      store = "steam";
    }
    {
      path = "${home}/.config/heroic";
      store = "heroic";
    }
    {
      database = "${home}/.local/share/lutris/pga.db";
      path = "${home}/.local/share/lutris";
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
}
