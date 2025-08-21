{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    nosModules.gaming.enable = lib.mkEnableOption "enables games and game launchers";
  };

  config = lib.mkIf config.nosModules.gaming.enable {
    programs = {
      steam.enable = true;
    };
    environment.systemPackages = with pkgs; [
      prismlauncher
    ];
  };
}
