{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    blender
    gimp
    inkscape
    graphviz
    krita
    audacity
  ];
}
