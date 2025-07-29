{
  config,
  pkgs,
  prefs,
  ...
}: {
  home = {
    packages = with pkgs; [
      waybar
      wofi
      hyprpaper
      cliphist
      wl-clipboard
      hyprcursor
      hyprshot
      hyprpicker
      hyprpolkitagent
      dunst
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
      HYPRCURSOR_THEME = "catppuccin-mocha-mauve-cursors";
      HYPRCURSOR_SIZE = "24";
      QT_QPA_PLATFORMTHEME = "qt6ct";
    };
  };

  programs = {
    waybar = import ./waybar.nix {inherit config pkgs;};
  };

  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        plugins = [
          # inputs.hyprland-easymotion.packages.${pkgs.system}.hyprland-easymotion
        ];
        settings = {
          monitor = ",highres,auto,1";
          source = "/etc/nixos/home/hyprland/macchiato.conf";
          workspace = "special:scratchpad, on-created-empty:[float] kitty --class scratchpad-terminal";
          windowrulev2 = [
            "suppressevent maximize, class:.*"
            "float,class:^(scratchpad-terminal)$"
            "size 60% 60%,class:^(scratchpad-terminal)$"
            "center,class:^(scratchpad-terminal)$"
            "workspace special:scratchpad,class:^(scratchpad-terminal)$"
            "noborder, onworkspace:w[t1]"
          ];
          bind = [
            "SUPER, T, exec, kitty"
            "SUPER, F, exec, zen-beta"
            "SUPER, C, exec, kitty nvim"
            "SUPER, D, exec, vesktop"
            "SUPER, W, killactive,"
            "SUPER, M, exit,"
            "SUPER, E, exec, thunar"
            "SUPER, V, togglefloating,"
            "SUPER, R, exec, wofi --show drun"
            "SUPER, B, exec, pkill -SIGUSR1 waybar"
            "SUPER, H, movefocus, l"
            "SUPER, L, movefocus, r"
            "SUPER, K, movefocus, u"
            "SUPER, J, movefocus, d"
            "SUPER, Q, exec, hyprctl reload"
            "SUPER, P, exec, hyprpicker -a -l -q"
            "SUPER, I, exec, cliphist list | wofi --dmenu --allow-images | cliphist decode | wl-copy"
            "SUPER SHIFT, V, exec, hyprctl dispatch togglefloating && hyprctl dispatch resizeactive exact 60% 60% && hyprctl dispatch center"
            "SUPER, O, exec, dunstctl action && dunstctl close"
            "SUPER SHIFT, O, exec, dunstctl close"
            "SUPER, 1, workspace, 1"
            "SUPER, 2, workspace, 2"
            "SUPER, 3, workspace, 3"
            "SUPER, 4, workspace, 4"
            "SUPER, 5, workspace, 5"
            "SUPER, 6, workspace, 6"
            "SUPER, 7, workspace, 7"
            "SUPER, 8, workspace, 8"
            "SUPER, 9, workspace, 9"
            "SUPER, 0, workspace, 10"
            "SUPER, S, togglespecialworkspace, scratchpad"
            "SUPER SHIFT, S, movetoworkspace, special:scratchpad"
            "SUPER SHIFT, 1, movetoworkspace, 1"
            "SUPER SHIFT, 2, movetoworkspace, 2"
            "SUPER SHIFT, 3, movetoworkspace, 3"
            "SUPER SHIFT, 4, movetoworkspace, 4"
            "SUPER SHIFT, 5, movetoworkspace, 5"
            "SUPER SHIFT, 6, movetoworkspace, 6"
            "SUPER SHIFT, 7, movetoworkspace, 7"
            "SUPER SHIFT, 8, movetoworkspace, 8"
            "SUPER SHIFT, 9, movetoworkspace, 9"
            "SUPER SHIFT, 0, movetoworkspace, 1"
            "SUPER SHIFT, H, movewindow, l"
            "SUPER SHIFT, J, movewindow, d"
            "SUPER SHIFT, K, movewindow, u"
            "SUPER SHIFT, L, movewindow, r"
            "SUPER SHIFT, Q, exec, kitty nvim ${prefs.data.treeDir}"
            "SUPER, Tab, workspace, m+1"
            "SUPER SHIFT, Tab, workspace, m-1"
            "SUPER, PRINT, exec, hyprshot -m window"
            "SUPER SHIFT, PRINT, exec, hyprshot -m output"
            ", PRINT, exec, hyprshot -m region"
            "ALT, Tab, cyclenext,"
            "ALT, Tab, bringactivetotop,"
            ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ];
          binde = [
            ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
            ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
            ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
            ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
            "SUPER ALT, L, resizeactive, 10 0"
            "SUPER ALT, H, resizeactive, -10 0"
            "SUPER ALT, K, resizeactive, 0 -10"
            "SUPER ALT, J, resizeactive, 0 10"
          ];
          bindm = [
            "SUPER, mouse:272, movewindow"
            "SUPER, mouse:273, resizewindow"
          ];
          exec = "hyprpaper";
          exec-once = [
            "waybar"
            "wl-paste --type text --watch cliphist store"
            "wl-paste --type image --watch cliphist store"
            "udiskie"
            "ibus-daemon -drx --panel disable"
            "systemctl --user start hyprpolkitagent"
            "dunst"
          ];
          general = {
            gaps_in = 0;
            gaps_out = 0;
            border_size = 1;
            "col.active_border" = "$pink $lavender $mauve 135deg";
            "col.inactive_border" = "$overlay0 $surface2 $surface0 45deg";
            layout = "dwindle";
            allow_tearing = false;
          };
          input = {
            kb_layout = "us";
            kb_options = "caps:swapescape,compose:ralt";
            follow_mouse = 1;
            touchpad = {
              disable_while_typing = false;
              clickfinger_behavior = true;
              tap-to-click = true;
              natural_scroll = true;
            };
            sensitivity = 0;
          };
          animations = {
            enabled = "false";
          };
          dwindle = {
            pseudotile = true;
            force_split = 0;
            preserve_split = true;
          };
          decoration = {
            rounding = 0;
            blur.enabled = false;
            shadow.enabled = false;
          };
          master = {
            new_status = "master";
          };
          xwayland = {
            force_zero_scaling = true;
          };
          cursor = {
            inactive_timeout = 3;
          };
          ecosystem = {
            no_donation_nag = true;
          };
          misc = {
            force_default_wallpaper = -1;
            disable_hyprland_logo = true;
            vfr = true;
          };
        };
      };
    };
  };

  services = {
    hyprpaper = {
      enable = true;
      settings = {
        preload = "${prefs.data.treeDir}/assets/wallpaper.jpg";
        splash = false;
        wallpaper = [
          "eDP-1,${prefs.data.treeDir}/assets/wallpaper.jpg"
        ];
      };
    };
    dunst = {
      enable = true;
    };
  };
}
