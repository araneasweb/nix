{
  config,
  pkgs,
  inputs,
  ...
}: {
  services = {
    picom = {
      enable = true;
    };
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
      };
      displayManager = {
        startx = {
          enable = true;
        };
      };
      xkb = {
        layout = "us";
        options = "caps:swapescape,compose:ralt";
      };
    };
  };
  environment = {
    systemPackages = [
      pkgs.xterm
      pkgs.rofi
      pkgs.xmobar
      pkgs.scrot
      pkgs.alsa-utils
      pkgs.clipmenu
      pkgs.nitrogen
    ];
  };
}
