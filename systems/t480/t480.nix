{
  prefs,
  lib,
  ...
}:
{

  imports = [
    ./hardware-configuration.nix
    ../shared.nix
  ]
  ++ (lib.optional prefs.settings.useHyprland ../../home/hyprland/hyprland.nix)
  ++ (lib.optional prefs.settings.useXmonad ../../home/xmonad/xmonad.nix);

  networking = {
    hostName = "t480";
    networkmanager.enable = true;
  };

  hardware.graphics.enable = true;

  swapDevices = [
    {
      device = "/swapfile";
      size = 32 * 1024;
    }
  ];

  services = {
    tlp.enable = true;
  };

}
