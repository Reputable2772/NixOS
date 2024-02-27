{ pkgs, inputs, ... }: {
  programs.vscode = {
    package = pkgs.vscodium;
    enable = true;
    mutableExtensionsDir = false;
    extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
      eamodio.gitlens
      github.vscode-github-actions
      pkief.material-icon-theme
      jnoortheen.nix-ide
      editorconfig.editorconfig
      rust-lang.rust-analyzer
      arcticicestudio.nord-visual-studio-code
      mkhl.direnv
      oderwat.indent-rainbow
    ];
    userSettings = {
      "editor.minimap.enabled" = false;
      "explorer.confirmDragAndDrop" = false;
      "workbench.colorTheme" = "Nord";
      "workbench.iconTheme" = "material-icon-theme";
    };
  };
}
