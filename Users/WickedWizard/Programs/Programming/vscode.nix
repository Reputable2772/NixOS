{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [ nixd nil ];

  # All VSCode related issues
  # https://github.com/nix-community/home-manager/issues/3822
  # https://github.com/NixOS/nixpkgs/issues/261205
  # https://github.com/NixOS/nixpkgs/issues/218031

  programs.vscode = {
    package = pkgs.vscodium;
    enable = true;
    extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
      eamodio.gitlens
      github.vscode-github-actions
      pkief.material-icon-theme
      editorconfig.editorconfig
      arcticicestudio.nord-visual-studio-code
      mkhl.direnv
      oderwat.indent-rainbow
      jnoortheen.nix-ide
      usernamehw.errorlens
    ];
    userSettings = {
      "editor.minimap.enabled" = false;
      "explorer.confirmDragAndDrop" = false;
      "workbench.colorTheme" = "Nord";
      "workbench.iconTheme" = "material-icon-theme";
      "diffEditor.ignoreTrimWhitespace" = false;
      "editor.formatOnSave" = true;
    };
  };

  xdg.dataFile.".vscode-oss/argv.json".text = ''
    // This configuration file allows you to pass permanent command line arguments to VS Code.
    // Only a subset of arguments is currently supported to reduce the likelihood of breaking
    // the installation.
    //
    // PLEASE DO NOT CHANGE WITHOUT UNDERSTANDING THE IMPACT
    //
    // NOTE: Changing this file requires a restart of VS Code.
    {
      // Use software rendering instead of hardware accelerated rendering.
      // This can help in cases where you see rendering issues in VS Code.
      // "disable-hardware-acceleration": true,

      // Allows to disable crash reporting.
      // Should restart the app if the value is changed.
      "enable-crash-reporter": false,

      // Unique id used for correlating crash reports sent from this instance.
      // Do not edit this value.
      "crash-reporter-id": "259850d6-487b-4bc4-9ea6-875cc91ac2bf",

      "password-store": "gnome-libsecret"
    }
  '';
}
