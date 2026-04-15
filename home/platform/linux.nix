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
