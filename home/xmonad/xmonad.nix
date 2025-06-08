{
  config,
  pkgs,
  inputs,
  ...
}: {
  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember-session --remember";
        };
      };
    };
    clipmenu = {
      enable = true;
    };
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
      pkgs.nitrogen
      pkgs.dmenu
    ];
  };
}
