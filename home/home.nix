{
  config,
  pkgs,
  ...
}: {

  imports = [
    ./hyprland_hm.nix
  ];

  home = {
    username = "aranea";
    homeDirectory = "/home/aranea";
    stateVersion = "25.05";
    file.".Xcompose" = {
      source = ./dotfiles/Xcompose;
      force = true;
    };
  };
  programs = {
    home-manager.enable = true;
    kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = 0;
      };
    };
    nushell = {
      enable = true;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      icon-theme = "Papirus-Dark";
    };
  };

  catppuccin = {
    kvantum.enable = true;
    nvim.enable = true;
    kitty.enable = true;
  };
}
