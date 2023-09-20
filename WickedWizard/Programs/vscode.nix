{ pkgs, ... }: {
  home.packages = with pkgs; [ rnix-lsp ];

  programs.vscode = {
    package = pkgs.vscodium;
    enable = true;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      ms-python.python
      esbenp.prettier-vscode
      dbaeumer.vscode-eslint
      eamodio.gitlens
      pkief.material-icon-theme
      jnoortheen.nix-ide
      arcticicestudio.nord-visual-studio-code
    ];
    userSettings = {
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "rnix-lsp";
      "explorer.confirmDragAndDrop" = false;
      "workbench.colorTheme" = "Nord";
    };
  };
}
