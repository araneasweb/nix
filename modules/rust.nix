{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    nosModules.rust.enable = lib.mkEnableOption "enables rust";
  };

  config = lib.mkIf config.nosModules.rust.enable {
    environment.systemPackages = with pkgs; [
      cargo
      rustc
      clippy
      rustfmt
    ];
  };
}
