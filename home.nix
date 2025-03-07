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
    enable = true;
    kvantum.enable = true;
    nvim.enable = true;
    kitty.enable = true;
  };
}
