{treeDir, ...}: {
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
        "nfu" = "sudo nix flake update --flake ${treeDir} && nix flake check ${treeDir}";
        "nrs" = "sudo nixos-rebuild switch --flake ${treeDir}";
        ":q" = "exit";
        "cls" = "clear && hyfetch";
        "kimg" = "kitty +kitten icat";
        "kdiff" = "kitty +kitten diff";
        "kssh" = "kitty +kitten ssh";
        "nixconf" = "nvim ${treeDir}";
        "flake-locate" = "echo ${treeDir}";
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
        nsh = ''
          if test (count $argv) -eq 0
            echo "Usage: nsh ..pkgs"
            return 1
          end
          set pkgs (for arg in $argv; echo nixpkgs#$arg; end)
          nix shell $pkgs
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
