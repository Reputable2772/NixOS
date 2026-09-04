{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Bitwarden silently blocks hibernate
  # Close it before hibernating.
  # bitwarden/clients#21661

  system-config.environment.etc."polkit-1/actions/com.bitwarden.Bitwarden.policy".source =
    /**
      File content taken from here
      https://github.com/bitwarden/clients/blob/main/apps/desktop/resources/com.bitwarden.desktop.policy

      Ref: https://bitwarden.com/help/biometrics/
    */
    pkgs.writeText "com.bitwarden.Bitwarden.policy" ''
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE policyconfig PUBLIC
       "-//freedesktop//DTD PolicyKit Policy Configuration 1.0//EN"
       "http://www.freedesktop.org/standards/PolicyKit/1.0/policyconfig.dtd">

      <policyconfig>
          <action id="com.bitwarden.Bitwarden.unlock">
            <description>Unlock Bitwarden</description>
            <message>Authenticate to unlock Bitwarden</message>
            <defaults>
              <allow_any>no</allow_any>
              <allow_inactive>no</allow_inactive>
              <allow_active>auth_self</allow_active>
            </defaults>
          </action>
      </policyconfig>
    '';

  wayland.windowManager.hyprland.settings.windowrule = [
    "match:initial_class (Bitwarden), workspace 2"
  ];

  services.ssh-agent.enable = lib.mkForce false;
  home.sessionVariables.SSH_AUTH_SOCK = "\${HOME:-${config.home.homeDirectory}}/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock";

  services.flatpak.packages = [ "com.bitwarden.desktop" ];
  xdg.autostart.flatpaks = [ "com.bitwarden.desktop" ];
}
