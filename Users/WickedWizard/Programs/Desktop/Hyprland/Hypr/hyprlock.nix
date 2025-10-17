{ config, sources, ... }:
{
  stylix.targets.hyprlock = {
    enable = true;
    useWallpaper = true;
  };

  programs.hyprlock = {
    inherit (config.wayland.windowManager.hyprland) enable;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };

      background.blur_passes = 3;
      input-field = {
        size = "300, 60";
        outline_thickness = 4;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        fade_on_empty = false;
        placeholder_text = ''<span foreground="##${config.lib.stylix.colors.base05}"><i>󰌾 Logged in as </i><span foreground="##${config.lib.stylix.colors.base0E}">$USER</span></span>'';
        hide_input = false;
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        capslock_color = "rgb(${config.lib.stylix.colors.base0A})";
        position = "0, -47";
        halign = "center";
        valign = "center";
      };
      time = {
        text = ''cmd[update:43200000] date +"%A, %d %B %Y"'';
        color = "rgb(${config.lib.stylix.colors.base05})";
        font_size = 25;
        # TOOD: Find out using Stylix
        # font_family = "$font";
        position = "-30, -150";
        halign = "right";
        valign = "top";
      };
      image = {
        path = "$HOME/.config/user.jpg";
        size = 100;
        # Could be base17, not sure.
        border_color = "rgb(${config.lib.stylix.colors.base0E})";
        position = "0, 75";
        halign = "center";
        valign = "center";
      };
    };
  };

  xdg.configFile."user.jpg".source = sources.wickedwizard_picture.src;

  wayland.windowManager.hyprland.settings.bind = [
    # "CTRL ALT, Delete, exec, hyprlock"
    "CTRL ALT, Delete, exec, systemctl suspend"
  ];
}
