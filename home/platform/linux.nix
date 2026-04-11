{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  home = {
    file.".XCompose" = {
      source = ../dotfiles/Xcompose;
      force = true;
    };

    file.".config/ibus/compose".text = builtins.readFile ../dotfiles/Xcompose;

    packages = with pkgs; [
      brightnessctl
      busybox
      ghostty
      catppuccin-cursors.mochaMauve
      catppuccin-gtk
      catppuccin-kvantum
      catppuccin-papirus-folders
      cheese
      dconf
      feh
      gcc
      gdb
      glibc
      gparted
      inetutils
      killall
      libX11
      libqalculate
      libreoffice-qt
      libselinux
      man-pages
      man-pages-posix
      nix-alien
      p11-kit
      pinentry-all
      proton-pass
      qutebrowser
      racket
      sioyek
      spotify
      swi-prolog-gui
      udiskie
      upower
      util-linux
      valgrind
      vesktop
      xarchiver
      xdg-user-dirs
      zoom-us
    ];
  };

  programs = {
    sioyek = {
      enable = true;
      config = {
        background_color = "#1e1e2e";
        text_highlight_color = "#f9e2af";
        visual_mark_color = "#7f849c";
        search_highlight_color = "#f9e2af";
        link_highlight_color = "#89b4fa";
        synctex_highlight_color = "#a6e3a1";
        highlight_color_a = "#f9e2af";
        highlight_color_b = "#a6e3a1";
        highlight_color_c = "#89dceb";
        highlight_color_d = "#eba0ac";
        highlight_color_e = "#cba6f7";
        highlight_color_f = "#f38ba8";
        highlight_color_g = "#f9e2af";
        custom_background_color = "#1e1e2e";
        custom_text_color = "#cdd6f4";
        ui_text_color = "#cdd6f4";
        ui_background_color = "#313244";
        ui_selected_text_color = "#cdd6f4";
        ui_selected_background_color = "#585b70";
        startup_commands = [ "toggle_custom_color" ];
        should_launch_new_instance = "1";
        should_launch_new_window = "1";
      };
    };

    tmux.extraConfig = lib.mkAfter ''
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'wl-copy'
      unbind ]
      bind ] run-shell 'tmux set-buffer -- "$(wl-paste -n)" \; paste-buffer -d'
    '';
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      icon-theme = "Papirus-Dark";
    };
  };

  xdg.configFile = {
    "xfce4/helpers.rc".text = ''
      TerminalEmulator = ghostty
    '';
  };
}
