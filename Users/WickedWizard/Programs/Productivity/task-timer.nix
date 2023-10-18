{ config, pkgs, ... }: {
  home.packages = with pkgs; [ khronos ];

  xdg.configFile."autostart/khronos.desktop".source = "${pkgs.khronos}/share/applications/io.github.lainsce.Khronos.desktop";
}
