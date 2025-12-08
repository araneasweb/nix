{
  pkgs,
  inputs,
  ...
}: {
  services = {
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
        extraPackages = haskellPackages: [
          haskellPackages.dbus
          haskellPackages.List
          haskellPackages.monad-logger
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
    libinput = {
      enable = true;
      touchpad = {
        sendEventsMode = "enabled";
        scrollMethod = "twofinger";
        naturalScrolling = false;
        tapping = true;
      };
    };
  };
  environment = {
    systemPackages = with pkgs; [
      xterm
      rofi
      xmobar
      scrot
      alsa-utils
      nitrogen
      dmenu
    ];
    sessionVariables = {
      CM_HISTLENGTH = 20;
      CM_LAUNCHER = "rofi";
    };
  };
}
