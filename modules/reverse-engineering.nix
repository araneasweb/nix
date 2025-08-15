{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    nosModules.reverseEngineering.enable = lib.mkEnableOption "enables reverse engineering tools";
  };

  config = lib.mkIf config.nosModules.reverseEngineering.enable {
    environment.systemPackages = with pkgs; [
      ghidra
      scanmem
      wireshark
      radare2
    ];
  };
}
