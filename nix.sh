#!bash

echo "Formatting and checking files."
nix fmt
nix flake check

echo "Dumping DConf"
dconf dump / | dconf2nix  --timeout 360 > ./WickedWizard/Programs/Desktop/Gnome/gnome.nix
sudo -u shuba dconf dump / | dconf2nix --timeout 360 > ./Shuba/gnome.nix

echo "Actually builiding"
rm -rf /home/wickedwizard/Documents/Browsers/Firefox/search.json.mozlz4 /home/wickedwizard/.config/mimeapps.list
sudo nixos-rebuild switch --flake .#nixos

echo "Changelog"
nix profile diff-closures -p /nix/var/nix/profiles/system
