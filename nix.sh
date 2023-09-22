#!bash

dconf dump / | dconf2nix  --timeout 360 > ./WickedWizard/Programs/Desktop/Gnome/gnome.nix
sudo -u shuba dconf dump / | dconf2nix --timeout 360 > ./Shuba/gnome.nix
nix fmt
nix flake check
rm -rf /home/wickedwizard/Documents/Browsers/Firefox/search.json.mozlz4 /home/wickedwizard/.config/mimeapps.list
sudo nixos-rebuild switch --flake .#nixos
