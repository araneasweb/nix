{
  config,
  pkgs,
  catppuccin,
  ...
}: {
  home = {
    file.".xmonad/./xmonad.hs".source = ./xmonad.hs;
    file.".config/nitrogen/bg-saved.cfg".text = ''
    [xin_-1]
    file=/etc/nixos/assets/wallpaper.jpg
    mode=5
    bgcolor=#000000
    '';
    pointerCursor = {
      x11.enable = true;
      gtk.enable = true;
      package = pkgs.catppuccin-cursors.mochaMauve;
      name = "catppuccin-mocha-mauve-cursors";
    };
  };

  services.picom = {
    enable = true;
    vSync = true;
  };

  programs = {
    rofi = {
      enable = true;
      terminal = "kitty";
      extraConfig = {
        modi = "drun,run";
        show-icons = true;
        drun-display-format = "{name}";
      };
    };
  };
}
