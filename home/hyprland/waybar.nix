{pkgs, ...}: {
  enable = true;
  style = ''
    * {
      border: none;
      border-radius: 0;
      min-height: 0;
      margin: 0;
      padding: 0;
      box-shadow: none;
      text-shadow: none;
    }

    #waybar {
      background: rgb(17, 17, 27);
      color: #cad3f5;
      font-family: Hack Nerd Font;
      font-size: 10pt;
    }

    #battery,
    #clock,
    #cpu,
    #language,
    #memory,
    #mode,
    #network,
    #pulseaudio,
    #temperature,
    #tray,
    #backlight,
    #idle_inhibitor,
    #disk,
    #user,
    #mpris {
      padding-left: 8pt;
      padding-right: 8pt;
    }

    #network.disconnected,
    #memory.warning,
    #cpu.warning,
    #temperature.warning,
    #battery.warning.discharging {
      color: #cdd6f4;
    }

    #mode {
      color: #cad3f5;
      background: #1e1e2e;
    }

    #workspaces button {
      padding-left: 2pt;
      padding-right: 2pt;
      color: #cad3f5;
    }

    #workspaces button.visible {
      color: #cba6f7;
    }

    #workspaces button.urgent {
      color: #f38ba8;
    }

    #window {
      margin-right: 5pt;
      margin-left: 10pt;
    }

    #idle_inhibitor {
      color: #cad3f5;
    }

    #pulseaudio {
      color: #cdd6f4;
    }

    #network {
      color: #cdd6f4;
    }

    #memory {
      color: #cdd6f4;
    }

    #cpu {
      color: #cdd6f4;
    }

    #temperature {
      color: #cdd6f4;
    }

    #language {
      color: #cdd6f4;
    }

    #battery {
      color: #cdd6f4;
    }

    #tray {
      color: #CBA6F7;
    }

    #clock.date {
      color: #cdd6f4;
    }

    #clock.time {
      color: #cdd6f4;
    }

    #custom-arrow {
      color: #6c7086;
    }
  '';
  settings = {
    mainBar = {
      layer = "top";
      position = "top";

      modules-left = [
        "hyprland/mode"
        "hyprland/workspaces"
        "custom/space"
        "custom/arrow"
        "hyprland/window"
      ];

      modules-right = [
        "tray"
        "custom/arrow"
        "pulseaudio"
        "custom/arrow"
        "network"
        "custom/arrow"
        "memory"
        "custom/arrow"
        "cpu"
        "custom/arrow"
        "temperature"
        "custom/arrow"
        "battery"
        "custom/arrow"
        "clock#date"
        "custom/arrow"
        "clock#time"
      ];

      tray = {
        icon-size = 14;
        spacing = 5;
        icons = {
          Spotify = "";
        };
      };

      battery = {
        interval = 10;
        states = {
          warning = 30;
          critical = 15;
        };
        format-time = "{H}:{M:02}";
        format = "{icon} {capacity}% ({time})";
        format-charging = " {capacity}% ({time})";
        format-charging-full = " {capacity}%";
        format-full = "{icon} {capacity}%";
        format-alt = "{icon} {power}W";
        format-icons = [
          " "
          " "
          " "
          " "
          " "
        ];
        tooltip = false;
      };

      "clock#time" = {
        interval = 10;
        format = "{:%H:%M}";
        tooltip = false;
      };

      "clock#date" = {
        interval = 20;
        # format = "{:%e %b %Y}";
        format = "{:%F}";
        tooltip = false;
      };

      cpu = {
        interval = 5;
        tooltip = false;
        format = "  {usage}%";
        format-alt = "  {load}";
        states = {
          warning = 70;
          critical = 90;
        };
      };

      "sway/language" = {
        format = " {}";
        min-length = 5;
        on-click = "${pkgs.sway}/bin/swaymsg 'input * xkb_switch_layout next'";
        tooltip = false;
      };

      memory = {
        interval = 5;
        format = "  {used:0.1f}G";
        states = {
          warning = 70;
          critical = 90;
        };
        tooltip = false;
      };

      network = {
        interval = 5;
        format-wifi = "  {essid} ({signalStrength}%)";
        format-ethernet = "󰛳 {ifname}";
        format-disconnected = "No connection";
        format-alt = "󰛳 {ipaddr}/{cidr}";
        tooltip = false;
      };

      "hyprland/mode" = {
        format = "{}";
        tooltip = false;
      };

      "hyprland/window" = {
        foramt = "{}";
        max-length = 30;
        tooltip = false;
      };

      "hyprland/workspaces" = {
        disable-scroll-wraparound = true;
        smooth-scrolling-threshold = 4;
        enable-bar-scroll = true;
        format = "{name}";
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-bluetooth = "{icon} {volume}%";
        format-muted = " ";
        format-icons = {
          headphone = " ";
          hands-free = " ";
          headset = " ";
          phone = " ";
          portable = " ";
          car = " ";
          default = [" " " "];
        };
        scroll-step = 1;
        on-click = "${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
        tooltip = false;
      };

      temperature = {
        critical-threshold = 90;
        interval = 5;
        format = "{icon} {temperatureC}°";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
        tooltip = false;
      };

      "custom/arrow" = {
        format = "//";
        tooltip = false;
      };

      "custom/space" = {
        format = " ";
        tooltip = false;
      };
    };
  };
}
