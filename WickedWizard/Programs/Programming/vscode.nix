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
      rust-lang.rust-analyzer
      arcticicestudio.nord-visual-studio-code
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "indent-rainbow";
        publisher = "oderwat";
        version = "8.3.1";
        sha256 = "sha256-dOicya0B2sriTcDSdCyhtp0Mcx5b6TUaFKVb0YU3jUc=";
      }
    ];
    userSettings = {
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "rnix-lsp";
      "explorer.confirmDragAndDrop" = false;
      "workbench.colorTheme" = "Nord";
      "workbench.iconTheme" = "material-icon-theme";
    };
  };
}
