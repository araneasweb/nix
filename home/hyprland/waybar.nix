{
  config,
  pkgs,
  ...
}: {
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
      font-family: JetBrains Mono, "Font Awesome 6 Free";
      font-size: 11pt;
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
      color: #1e1e2e;
    }

    #mode {
      color: #cad3f5;
      background: #1e1e2e;
    }

    #workspaces button {
      padding-left: 2pt;
      padding-right: 2pt;
      color: #cad3f5;
      background: #313244;
    }

    #workspaces button.visible {
      color: #cad3f5;
      background: #24273a;
    }

    #workspaces button.focused {
      color: #1e1e2e;
      background: #24273a;
    }

    #workspaces button.urgent {
      color: #1e1e2e;
      background: #c6a0f6;
    }

    #workspaces button:hover {
      background: #1e1e2e;
      color: #cad3f5;
    }

    #window {
      margin-right: 35pt;
      margin-left: 35pt;
    }

    #idle_inhibitor {
      background: #458588;
      color: #cad3f5;
    }

    #pulseaudio {
      background: #9043EF;
      color: #1e1e2e;
    }

    #network {
      background: #9C56F1;
      color: #1e1e2e;
    }

    #memory {
      background: #A769F2;
      color: #1e1e2e;
    }

    #cpu {
      background: #AD73F3;
      color: #1e1e2e;
    }

    #temperature {
      background: #B27CF4;
      color: #1e1e2e;
    }

    #language {
      background: #fabd2f;
      color: #1e1e2e;
    }

    #battery {
      background: #BD8EF5;
      color: #1e1e2e;
    }

    #tray {
      background: #CBA6F7;
    }

    #clock.date {
      background: #CBA6F7;
      color: #1e1e2e;
    }

    #clock.time {
      background: #D5B6F9;
      color: #1e1e2e;
    }

    #custom-arrow1 {
      font-size: 11pt;
      color: #D5B6F9;
      background: #CBA6F7;
    }

    #custom-arrow2 {
      font-size: 11pt;
      color: #CBA6F7;
      background: #BD8EF5;
    }

    #custom-arrow4 {
      font-size: 11pt;
      color: #BD8EF5;
      background: #B27CF4;
    }

    #custom-arrow5 {
      font-size: 11pt;
      color: #B27CF4;
      background: #AD73F3;
    }

    #custom-arrow6 {
      font-size: 11pt;
      color: #AD73F3;
      background: #A769F2;
    }

    #custom-arrow7 {
      font-size: 11pt;
      color: #A769F2;
      background: #9C56F1;
    }

    #custom-arrow8 {
      font-size: 11pt;
      color: #9C56F1;
      background: #9043EF;
    }

    #custom-arrow9 {
      font-size: 11pt;
      color: #9043EF;
      background: #11111B;
    }

    #custom-arrow11 {
      font-size: 11pt;
      color: #313244;
      background: #11111B;
    }
  '';
  settings = {
    mainBar = {
      layer = "top";
      position = "top";

      modules-left = [
        "hyprland/mode"
        "hyprland/workspaces"
        "custom/arrow11"
        "hyprland/window"
      ];

      modules-right = [
        "custom/arrow9"
        "pulseaudio"
        "custom/arrow8"
        "network"
        "custom/arrow7"
        "memory"
        "custom/arrow6"
        "cpu"
        "custom/arrow5"
        "temperature"
        "custom/arrow4"
        "battery"
        "custom/arrow2"
        "clock#date"
        "custom/arrow1"
        "clock#time"
      ];

      battery = {
        interval = 10;
        states = {
          warning = 30;
          critical = 15;
        };
        format-time = "{H}:{M:02}";
        format = "{icon} {capacity}% ({time})";
        format-charging = "  {capacity}% ({time})";
        format-charging-full = "  {capacity}%";
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
        format = "{:%e %b %Y}";
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
        format = "   {used:0.1f}G/{total:0.1f}G";
        states = {
          warning = 70;
          critical = 90;
        };
        tooltip = false;
      };

      network = {
        interval = 5;
        format-wifi = "   {essid} ({signalStrength}%)";
        format-ethernet = "󰛳  {ifname}";
        format-disconnected = "No connection";
        format-alt = "󰛳  {ipaddr}/{cidr}";
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

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
        tooltip = false;
      };

      tray = {
        icon-size = 18;
      };

      "custom/arrow1" = {
        format = "";
        tooltip = false;
      };

      "custom/arrow2" = {
        format = "";
        tooltip = false;
      };

      "custom/arrow3" = {
        format = "";
        tooltip = false;
      };

      "custom/arrow4" = {
        format = "";
        tooltip = false;
      };

      "custom/arrow5" = {
        format = "";
        tooltip = false;
      };

      "custom/arrow6" = {
        format = "";
        tooltip = false;
      };

      "custom/arrow7" = {
        format = "";
        tooltip = false;
      };

      "custom/arrow8" = {
        format = "";
        tooltip = false;
      };

      "custom/arrow9" = {
        format = "";
        tooltip = false;
      };

      "custom/arrow10" = {
        format = "";
        tooltip = false;
      };

      "custom/arrow11" = {
        format = "";
        tooltip = false;
      };
    };
  };
}
