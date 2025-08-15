{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    nosModules.digitalDesign.enable = lib.mkEnableOption "enables digital design tools";
  };

  config = lib.mkIf config.nosModules.digitalDesign.enable {
    environment.systemPackages = with pkgs; [
      blender
      gimp
      inkscape
      graphviz
      krita
      audacity
    ];
  };
}
