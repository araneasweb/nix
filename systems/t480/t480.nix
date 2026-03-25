{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

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

  services.tlp.enable = true;
}
