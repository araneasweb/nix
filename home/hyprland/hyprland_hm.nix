{
  config,
  pkgs,
  treeDir,
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
        preload = "${treeDir}/assets/wallpaper.jpg";
        splash = false;
        wallpaper = [
          "eDP-1,${treeDir}/assets/wallpaper.jpg"
        ];
      };
    };
  };
}
