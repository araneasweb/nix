{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs = {
    hyprland.enable = true;
  };
  environment = {
    systemPackages = [
      pkgs.waybar
      pkgs.wofi
      pkgs.hyprpaper
      pkgs.cliphist
      pkgs.wl-clipboard
      pkgs.hyprcursor
      pkgs.hyprshot
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
      HYPRCURSOR_THEME = "catppuccin-mocha-mauve-cursors";
      HYPRCURSOR_SIZE = "24";
    };
  };
}
