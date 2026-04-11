{
  t480 = {
    system = "x86_64-linux";
    treeDir = "/etc/nixos";
    desktop = "hyprland";
    module = ../hosts/nixos/t480;
  };

  azalea = {
    system = "x86_64-linux";
    treeDir = "/etc/nixos";
    desktop = "cosmic";
    module = ../hosts/nixos/azalea;
  };

  a2681 = {
    system = "aarch64-darwin";
    treeDir = "~/nix/";
    desktop = "none";
    module = ../hosts/darwin/a2681;
  };
}
