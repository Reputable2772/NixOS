{ lib, ... }:
let
  num = [
    1
    2
    3
    4
    5
    6
    7
    8
    9
  ];

  mkBind = key: dsp: {
    _args = [
      key
      (lib.generators.mkLuaInline dsp)
    ];
  };

  mkBindOpt = key: dsp: opts: {
    _args = [
      key
      (lib.generators.mkLuaInline dsp)
      opts
    ];
  };
in
{
  wayland.windowManager.hyprland.settings.bind = [
    # Focus Shift
    (mkBind "SUPER + k" ''hl.dsp.focus({ direction = "up" })'')
    (mkBind "SUPER + j" ''hl.dsp.focus({ direction = "down" })'')
    (mkBind "SUPER + l" ''hl.dsp.focus({ direction = "right" })'')
    (mkBind "SUPER + h" ''hl.dsp.focus({ direction = "left" })'')

    # Window Focus Shifting
    (mkBind "ALT + Tab" ''
      function()
        hl.dispatch(hl.dsp.window.cycle_next())
        hl.dispatch(hl.dsp.window.bring_to_top())
      end
    '')

    # Workspace shifting, more added to end of list.
    (mkBind "SUPER + mouse_down" ''hl.dsp.focus({ workspace = "e-1" })'')
    (mkBind "SUPER + mouse_up" ''hl.dsp.focus({ workspace = "e+1" })'')
    (mkBind "CTRL + ALT + left" ''hl.dsp.focus({ workspace = "e-1" })'')
    (mkBind "CTRL + ALT + right" ''hl.dsp.focus({ workspace = "e+1" })'')

    # Window to workspace shifting, more at end of list.
    (mkBind "CTRL + SUPER + right" ''hl.dsp.window.move({ workspace = "+1" })'')
    (mkBind "CTRL + SUPER + left" ''hl.dsp.window.move({ workspace = "-1" })'')

    # Move to next empty workspace
    (mkBind "CTRL + ALT + E" ''hl.dsp.focus({ workspace = "empty" })'')
    (mkBind "SUPER + CTRL + E" ''hl.dsp.window.move({ workspace = "empty" })'')

    # Misc
    (mkBind "CTRL + SHIFT + Q" "hl.dsp.window.close()")
    (mkBind "ALT + F" ''hl.dsp.window.float({ action = "toggle" })'')
    (mkBind "SUPER + F" "hl.dsp.window.fullscreen()")
    (mkBind "SUPER + O" "hl.dsp.window.fullscreen_state({ internal = -1, client = 2 })")
    (mkBind "SUPER + P" "hl.dsp.window.pseudo()")
    (mkBind "SUPER + SHIFT + P" ''hl.dsp.layout("togglesplit")'')
    (mkBind "SUPER + CTRL + P" "hl.dsp.window.pin()")
    (mkBind "SUPER + M" ''hl.dsp.window.fullscreen({ mode = "maximized" })'')
    (mkBind "SUPER + space" ''hl.dsp.window.float({ action = "toggle" })'')

    # Resize active window
    (mkBindOpt "SUPER + CTRL + k" "hl.dsp.window.resize({ x = 0, y = -20, relative = true })" {
      repeating = true;
    })
    (mkBindOpt "SUPER + CTRL + j" "hl.dsp.window.resize({ x = 0, y = 20, relative = true })" {
      repeating = true;
    })
    (mkBindOpt "SUPER + CTRL + l" "hl.dsp.window.resize({ x = 20, y = 0, relative = true })" {
      repeating = true;
    })
    (mkBindOpt "SUPER + CTRL + h" "hl.dsp.window.resize({ x = -20, y = 0, relative = true })" {
      repeating = true;
    })

    # Move Windows
    (mkBindOpt "SUPER + SHIFT + h" ''hl.dsp.window.move({ direction = "left" })'' {
      repeating = true;
    })
    (mkBindOpt "SUPER + SHIFT + l" ''hl.dsp.window.move({ direction = "right" })'' {
      repeating = true;
    })
    (mkBindOpt "SUPER + SHIFT + k" ''hl.dsp.window.move({ direction = "up" })'' {
      repeating = true;
    })
    (mkBindOpt "SUPER + SHIFT + j" ''hl.dsp.window.move({ direction = "down" })'' {
      repeating = true;
    })

    # Window move and resize
    (mkBindOpt "SUPER + mouse:272" "hl.dsp.window.drag()" {
      mouse = true;
    })
    (mkBindOpt "SUPER + mouse:273" "hl.dsp.window.resize()" {
      mouse = true;
    })

    # Audio
    (mkBindOpt "XF86AudioPrev" ''hl.dsp.exec_cmd("playerctl --player playerctld previous")'' {
      locked = true;
    })
    (mkBindOpt "XF86AudioNext" ''hl.dsp.exec_cmd("playerctl --player playerctld next")'' {
      locked = true;
    })
    (mkBindOpt "XF86AudioPlay" ''hl.dsp.exec_cmd("playerctl --player playerctld play-pause")'' {
      locked = true;
    })
  ]
  ++ (map (i: mkBind "SUPER + ${toString i}" "hl.dsp.focus({ workspace = ${toString i} })") num)
  ++ (map (
    i: mkBind "CTRL + SUPER + ${toString i}" ''hl.dsp.window.move({ workspace = "${toString i}" })''
  ) num);
}
