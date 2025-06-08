{
  config,
  pkgs,
  inputs,
  ...
}: {
  services = {
    xserver = {
      enable = true;
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        ghcArgs = [
         "-hidir /tmp"
          "-odir /tmp"
         "-i${inputs.xmonad-contexts}"
        ];
        config = builtins.readFile ./xmonad.hs;
      };
      displayManager = {
        startx = {
          enable = true;
        };
      };
    };
  };
  environment = {
    systemPackages = [
      pkgs.xterm
    ];
  };
}
