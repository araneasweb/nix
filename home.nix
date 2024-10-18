{ config, pkgs, ... }:

{

  home = {
    username = "aranea";
    homeDirectory = "/home/aranea";
    stateVersion = "24.05";
  };

  programs = {
    home-manager.enable = true;
    kitty = {
      enable = true;
      catppuccin.enable = true;
      settings = {
        confirm_os_window_close = 0;
      };
    };
    neovim = {
      enable = true;
      catppuccin.enable = true;
      viAlias = true;
      extraConfig = "
        set number
        set title
        set encoding=utf-8
      ";
    };
    waybar = import ./waybar.nix { inherit config pkgs; };
  };

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
      ];
    };
    "org/gnome/desktop/interface" = {
      icon-theme = "Papirus-Dark";
    };
      
  };

  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        extraConfig = builtins.readFile ./hyprland.conf;
      };
    };
  };

  services = {
    hyprpaper = {
      enable = true;
      settings = {
        preload = "/etc/nixos/wallpaper.jpg";
        splash = false;
        wallpaper = [
          "eDP-1,/etc/nixos/wallpaper.jpg"
        ];
      };
    };
  };
  
  catppuccin.enable = true;
  qt.style.catppuccin.enable = true;

}



   