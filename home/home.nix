{
  prefs,
  pkgs,
  ...
}: {
  home = {
    inherit (prefs.data) username;
    homeDirectory = "/home/${prefs.data.username}";
    stateVersion = "25.05";
    file.".XCompose" = {
      source = ./dotfiles/Xcompose;
      force = true;
    };
    file.".config/ibus/compose" = {
      text = builtins.readFile ./dotfiles/Xcompose;
    };
    sessionVariables = {
      TERMINAL = "ghostty";
    };
  };

  programs = {
    home-manager.enable = true;
    ghostty = {
      enable = true;
      settings = {
        font-family = "Hack Nerd Font Mono";
        font-size = 9;

        window-padding-x = 0;
        window-padding-y = 0;
        window-padding-balance = true;

        window-decoration = "none";
        window-show-tab-bar = "never";

        clipboard-read = "allow";
        clipboard-write = "allow";

        initial-command = "tmux new-session";

        keybind = [
          "ctrl+equal=increase_font_size:1"
          "ctrl+minus=decrease_font_size:1"
          "ctrl+shift+r=reload_config"
        ];
      };
      clearDefaultKeybinds = true;
    };
    kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = 0;
        font = "Hack Nerd Font Mono";
        font_family = "Hack Nerd Font Mono";
        font_size = 9;
        window_padding_width = 0;
        hide_window_decorations = "yes";
        tab_bar_style = "hidden";
        hide_tab_bar_when_single_tab = "yes";
        # shell = "tmux new-session";
        allow_osc42_clipboard = "yes";
        scrollback_lines = 10000;
      };
      extraConfig = ''
        clear_all_shortcuts yes
        map ctrl+shift+equal change_font_size current +1.0
        map ctrl+shift+minus change_font_size current -1.0
      '';
    };
    fish = {
      enable = true;
      shellAliases = {
        "nfu" = "sudo nix flake update --flake ${prefs.data.treeDir} && nix flake check ${prefs.data.treeDir}";
        "nrs" = "nixos-rebuild switch --sudo --flake ${prefs.data.treeDir}";
        ":q" = "exit";
        "cls" = "clear && hyfetch";
        "nixconf" = "nvim ${prefs.data.treeDir}";
        "tlocale" = "echo ${prefs.data.treeDir}";
        "fzg" = "rg . | fzf --print0 -e";
        "reload" = "source ~/.config/fish/config.fish";
        "cd" = "z";
        "cdi" = "zi";
        "ls" = "eza";
        "l" = "ls -lah";
        "lt" = "ls --long --tree";
        "ltg" = "ls --long --tree --git-ignore";
        "ll" = "ls -l";
      };
      shellInit = ''
        set -g fish_greeting ""
      '';
      interactiveShellInit = ''
        nix-your-shell fish | source
        zoxide init fish | source
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
        racketi = ''
          if test (count $argv) -eq 0
              echo "Usage: racketi filename"
              return 1
          end
          racket -i -e "(enter! \"$argv[1]\")"
        '';
      };
    };
    starship = {
      enable = true;
      settings = {
        character = {
          success_symbol = "[λ](bold green)";
          error_symbol = "[λ](bold red)";
          vicmd_symbol = "[Γ](bold green)";
          vimcmd_visual_symbol = "[Γ](bold yellow)";
          vimcmd_replace_symbol = "[Γ](bold purple)";
          vimcmd_replace_one_symbol = "[Γ](bold purple)";
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
        should_launch_new_instance = "1";
        should_launch_new_window = "1";
      };
      enable = true;
    };
    tmux = {
      enable = true;
      shortcut = "Space";
      terminal = "screen-256color";
      plugins = with pkgs.tmuxPlugins; [
        prefix-highlight
        jump
      ];
      extraConfig = ''
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        bind H resize-pane -L 5
        bind J resize-pane -D 5
        bind K resize-pane -U 5
        bind L resize-pane -R 5

        bind S choose-session

        setw -g mode-keys vi
        bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'wl-copy'
        bind -T copy-mode-vi Y send-keys -X copy-line
        bind-key -T copy-mode-vi 'v' send -X begin-selection

        set -g status-right ""

        set -g allow-passthrough on
        set -g set-clipboard on

        unbind ]
        bind ] run-shell 'tmux set-buffer -- "$(wl-paste -n)" \; paste-buffer -d'

        set -g base-index 1
        setw -g pane-base-index 1

        set-option -s escape-time 0
        set -g history-limit 50000

      '';
    };
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

  catppuccin = {
    enable = true;
    hyprland.enable = false;
  };
}
