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
    systemPackages = with pkgs; [
      waybar
      wofi
      hyprpaper
      cliphist
      wl-clipboard
      hyprcursor
      hyprshot
      networkmanagerapplet
      hyprpicker
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
      HYPRCURSOR_THEME = "catppuccin-mocha-mauve-cursors";
      HYPRCURSOR_SIZE = "24";
      QT_QPA_PLATFORMTHEME = "qt6ct";
    };
  };
}
