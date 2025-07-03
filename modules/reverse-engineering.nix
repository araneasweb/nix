{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ghidra
    scanmem
    wireshark
  ];
}
