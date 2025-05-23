{
  config',
  lib,
  ...
}:
{
  # Runs on xwayland by default(?). Change it in chrome://flags

  services.flatpak = {
    packages = [ "io.github.ungoogled_software.ungoogled_chromium" ];
    overrides."io.github.ungoogled_software.ungoogled_chromium" =
      lib.optionalAttrs (config'.dir ? browsers && config'.dir.browsers != null)
        {
          Context.filesystems = "${config'.dir.browsers}/Chromium";
          Environment.CHROME_USER_DATA_DIR = "${config'.dir.browsers}/Chromium";
        };
  };
}
