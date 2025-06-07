{
  config,
  pkgs,
  ...
}: {
  programs = {
    waybar = import ./waybar.nix {inherit config pkgs;};
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
        preload = "/etc/nixos/assets/wallpaper.jpg";
        splash = false;
        wallpaper = [
          "eDP-1,/etc/nixos/assets/wallpaper.jpg"
        ];
      };
    };
  };
}
