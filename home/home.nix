{useHyprland, ...}: {
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
        font = "Hack Nerd Font";
        font_family = "Hack Nerd Font";
      };
    };
    fish = {
      enable = true;
      shellAliases = {
        "nfu" = "sudo nix flake update --flake /etc/nixos/ && nix flake check";
        "nrs" = "sudo nixos-rebuild switch";
        ":q" = "exit";
        "cls" = "clear && hyfetch";
        "kimg" = "kitty +kitten icat";
        "kdiff" = "kitty +kitten diff";
        "kssh" = "kitty +kitten ssh";
        "nixconf" = "nvim /etc/nixos";
      };
      shellInit = ''
        set -g fish_greeting ""
      '';
      interactiveShellInit = ''
        hyfetch
      '';
      functions = {
        rungcc = ''
          if test (count $argv) -eq 0
              echo "Usage: rungcc filename"
              return 1
          end
          set file $argv[1]
          set exe_name ".tmp_gcc"
          gcc $file -o $exe_name && ./$exe_name && rm $exe_name
        '';
        heval = ''
          if test (count $argv) -eq 0
            echo "Usage: heval ..expr"
            return 1
          end
          set expr (string join " " $argv)
          ghc -e "print ($expr)"
        '';
      };
    };
    starship = {
      enable = true;
      settings = {
        character = {
          success_symbol = "[λ](bold green)";
          error_symbol = "[λ](bold red)";
        };
      };
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
