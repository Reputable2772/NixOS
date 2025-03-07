{ config, ... }:
let
  inherit (config.lib.stylix.colors.withHashtag)
    base00
    base04
    base05
    base06
    base08
    base09
    base0A
    base0B
    base0D
    base0E
    base0F
    ;
in
{
  # Uses base24 to base16 fallbacks, since stylix currently does not support
  # base24 themes. danth/stylix#252
  # Fallbacks: https://github.com/tinted-theming/base24/blob/main/styling.md#base24-fallbacks
  # Properties that use fallback are indicated by a '# #' after the semicolon.
  programs.bottom = {
    enable = true;
    settings = {
      flags = {
        group_processes = true;
      };
      styles = {
        tables.headers.color = base06;
        cpu = {
          all_entry_color = base06;
          avg_entry_color = base08; # #
          cpu_core_colors = [
            base08
            base09
            base0A
            base0B
            base0D # #
            base0E
          ];
        };
        memory = {
          ram_color = base0B;
          swap_color = base09;
          gpu_colors = [
            base0D # #
            base0E
            base08
            base09
            base0A
            base0B
          ];
          arc_color = base0D;
        };
        network = {
          rx_color = base0B;
          tx_color = base08;
        };
        widgets = {
          widget_title.color = base0F;
          border_color = base04;
          selected_border_color = base0E; # #
          text.color = base05;
          selected_text = {
            color = base00; # #
            bg_color = base0E;
          };
        };
        # Catppuccin's subtext1 property seems to be eliminated from the base24 color scheme?
        # Leave empty for now
        # graphs.graph_color = "#a6adc8";
        battery = {
          high_battery_color = base0B;
          medium_battery_color = base0A;
          low_battery_color = base08;
        };
      };
    };
  };
}
