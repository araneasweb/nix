{
  config,
  pkgs,
  ...
}: {
  home = {
    username = "aranea";
    homeDirectory = "/home/aranea";
    stateVersion = "25.05";
  };
  programs = {
    home-manager.enable = true;
    kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = 0;
      };
    };
    ghostty = {
      enable = true;
      settings = {
        theme = "catppuccin-mocha";
        font-size = 10;
      };
      themes = {
        catppuccin-mocha = {
          palette = [
            "0=#45475a"
            "1=#f38ba8"
            "2=#a6e3a1"
            "3=#f9e2af"
            "4=#89b4fa"
            "5=#f5c2e7"
            "6=#94e2d5"
            "7=#bac2de"
            "8=#585b70"
            "9=#f38ba8"
            "10=#a6e3a1"
            "11=#f9e2af"
            "12=#89b4fa"
            "13=#f5c2e7"
            "14=#94e2d5"
            "15=#a6adc8"
          ];
          background = "1e1e2e";
          foreground = "cdd6f4";
          cursor-color = "f5e0dc";
          selection-background = "353749";
          selection-foreground = "cdd6f4";
        };
      };
    };
    nushell = {
      enable = true;
    };
    waybar = import ./waybar.nix {inherit config pkgs;};
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

  catppuccin = {
    # enable = true;
    kvantum.enable = true;
    nvim.enable = true;
    kitty.enable = true;
  };
}
