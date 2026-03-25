{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "azalea";
    networkmanager.enable = true;
  };

  hardware.graphics.enable = true;

  swapDevices = [
    {
      device = "/swapfile";
      size = 32 * 1024;
    }
  ];
}
