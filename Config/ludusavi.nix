{ home ? "", games ? "" }: {
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
}