{
  pkgs,
  inputs,
  ...
}: {
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
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
      hyprpicker
      hyprpolkitagent
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
