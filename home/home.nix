{
  useHyprland,
  ...
}: {

  home = {
    username = "aranea";
    homeDirectory = "/home/aranea";
    stateVersion = "25.05";
    file.".Xcompose" = {
      source = ./dotfiles/Xcompose;
      force = true;
    };
    sessionVariables = {
      TERMINAL = "kitty";
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

  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator = kitty
  '';

  catppuccin = {
    kvantum.enable = true;
    nvim.enable = true;
    kitty.enable = true;
    rofi.enable = true;
  };
}
