{prefs, ...}: {
  home = {
    inherit (prefs.data) username;
    homeDirectory = "/home/${prefs.data.username}";
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
        font_size = 10;
      };
    };
    fish = {
      enable = true;
      shellAliases = {
        "nfu" = "sudo nix flake update --flake ${prefs.data.treeDir} && nix flake check ${prefs.data.treeDir}";
        "nrs" = "nixos-rebuild switch --sudo --flake ${prefs.data.treeDir}";
        ":q" = "exit";
        "cls" = "clear && hyfetch";
        "kimg" = "kitty +kitten icat";
        "kdiff" = "kitty +kitten diff";
        "kssh" = "kitty +kitten ssh";
        "nixconf" = "nvim ${prefs.data.treeDir}";
        "tlocale" = "echo ${prefs.data.treeDir}";
        "fzg" = "rg . | fzf --print0 -e";
        "reload" = "source ~/.config/fish/config.fish";
      };
      shellInit = ''
        set -g fish_greeting ""
      '';
      interactiveShellInit = ''
        nix-your-shell fish | source
      '';
      functions = {
        rungcc = ''
          if test (count $argv) -ne 1
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
        ndv = ''
          if test (count $argv) -ne 1
            echo "Usage: ndv envname"
            return 1
          end
          set envname $argv[1]
          nix flake init -t ${prefs.data.treeDir}/devflakes#$envname
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
    sioyek = {
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
        startup_commands = "toggle_custom_color";
      };
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
    enable = true;
    hyprland.enable = false;
  };
}
