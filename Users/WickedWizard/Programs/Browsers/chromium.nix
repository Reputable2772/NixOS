{ config, pkgs, ... }: {
  home.packages = with pkgs; [ ungoogled-chromium ];

  home.sessionVariables = {
    CHROME_USER_DATA_DIR = "$HOME/Documents/Browsers/Chromium";
  };

  xdg.desktopEntries = {
    Computer_Class = {
      name = "Computer Class";
      genericName = "Class";
      exec = ''
        sh -c "chromium --new-window \"https://app.zoom.us/wc/3095436847/join?from=join&pwd=srgs@omr\" --new-window \"https://app.zoom.us/wc/72459095023/join?from=join&pwd=cs123\" & obs"
      '';
      terminal = false;
      icon = "chromium";
      type = "Application";
    };
  };
}
