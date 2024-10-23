#!/bin/bash
sudo -i
(ls /etc/nixos/hardware-configuration.nix >> /dev/null 2>&1) || nixos-generate-config
hardwareconfig=$(mktemp)
mv /etc/hardware-configuration.nix "$hardwareconfig"
rm -rf /etc/nixos
rm ./hardware-configuration.nix
cp ./ /etc/nixos
cd /etc/nixos
mv "$hardwareconfig" /etc/nixos/hardware-configuration.nix
nixos-rebuild switch -- flake .#t480
