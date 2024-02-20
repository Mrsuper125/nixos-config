{
  lib,
  config, pkgs, ...
}: {
  programs.waybar = with config.colorScheme.palette;{
    enable = true;
    systemd.enable = true;
    style = ''
      * {
      font-family: JetBrainsMono Nerd Font Mono;
      font-size: 13px;
      border-radius: 0px;
      }

      window#waybar {
      background-color: #${base00};
      border-radius: 0px;
      transition-property: background-color;
      transition-duration: .5s;
      }

      button {
          border: none;
      }

      button:hover {
          background: inherit;
      }

      #workspaces {
          margin-bottom: 10px;
          margin-top: 10px;
          border-radius: 5px;
          background-color: #${base01};
          padding-left: 7px;
          padding-right: 7px;
      }

      #workspaces button {
          color: #${base0B};
          padding: 5px;
      }

      #workspaces button.empty {
          color: #${base05};
      }

      #workspaces button:hover {
          background: rgba(0, 0, 0, 0.2);
      }

      #workspaces button.active {
          color: #${base0A};
      }

      #workspaces button.urgent {
          color: #${base08};
      }

      #window {
          margin: 0 4px;
      }

      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }

      #clock,
      #group-audio,
      #group-power,
      #backlight,
      #battery,
      #network,
      #memory,
      #group-audio,
      #custom-media,
      #language,
      #privacy,
      #tray,
      #cpu,
      #custom-cava {
          padding: 0 10px;
          background-color: #${base01};
          border-radius: 5px;
          color: #${base05};
          padding: 2px;
          padding-left: 10px;
          padding-right: 10px;
          margin-top: 10px;
          margin-bottom: 10px;
      }

      #network.disconnected {
          background-color: #${base08};
      }

      #battery.critical:not(.charging) {
          background-color: #${base08};
          color: #${base01};
      }

      #pulseaudio, #pulseaudio-slider {
          background-color: #${base01};
          color: #${base05};
          border-radius: 5px;
      }

      #pulseaudio-slider {
          margin-right: 10px;
          padding: 0;
          min-width: 100px;
      }

      slider {
          margin: 0;
          padding: 0;
          min-height: 0px;
          min-width: 0px;
          border-radius: 5px;
          box-shadow: none;
          background-color: #${base07};
      }

      #custom-reboot,
      #custom-lock,
      #custom-quit {
          color: #${base05};
          margin-left: 5px;
          margin-right: 5px;
          padding: 2px;
          background-color: #${base01};
      }
      #custom-reboot:hover,
      #custom-lock:hover,
      #custom-quit:hover {
          color: #${base0A};
      }

      #custom-media {
          margin: 10px;
          margin-right: 0px;
          padding: 2px;
          padding-left: 10px;
          padding-right: 10px;
      }
      #custom-power {
          color: #${base08};
          margin-left: 5px;
          margin-right: 5px;
          padding: 2px;
          background-color: #${base01};
      }

      #group-power {
          padding: 2px;
          padding-left: 10px;
          padding-right: 10px;
          margin-top: 10px;
          margin-bottom: 10px;
          margin-right: 10px;
      }

      #custom-media {
          min-width: 100px;
          margin-right: 0px;
      }
    '';
    settings = [{
      position = "top";
      layer = "top";
      height = 30;
      spacing = 5;

      modules-left = [

        "image/album-art"

        "group/group-audio"
      ];
      modules-center = ["hyprland/workspaces"];
      modules-right =
        # (lib.optionals config.home-manager.backlight.enable ["backlight"])
        # ++ (lib.optionals config.home-manager.battery.enable ["battery"]) ++
        [
          "cpu"
          "memory"
          "network"
          "hyprland/language"
          "keyboard-state"
          "clock"
          "privacy"
          "tray"
          "group/group-power"
          # "custom/power"
          # "custom/quit"
          # "custom/lock"
          # "custom/reboot"
        ];
  
      "hyprland/workspaces" = {
        format = "{icon}";
        # format = "<span font='13'>{icon}</span>";
        format-icons = {
          empty = "<span font='11' rise='-3000'>E</span>";
          active = "<span font='13' rise='-3000'>A</span>";
          default = "<span font='13' rise='-3000'>D</span>";
        };
        # persistent-workspaces = {  for now I decided to go without this stuff. There is no actual workspace functionality for now
        #   "*" = 10;
        # };

        on-click = "activate";
        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
        sort-by-number = true;
      };

      keyboard-state = {
        format = "{name} <span font='12'>{icon}</span>";
        format-icons = { 
          locked = "";
          unlocked = "";
        };
      };
      "image/album-art" = {
        path = "/tmp/cover.jpeg";
        size = 32;
        interval = 5;
        on-click = "mpc toggle";
      };
      "hyprland/language" = {
        format = "<span font='16' rise='-2500' color='#${base07}'>󰌌 </span> {}";
        format-en = "US";
        format-ru = "RU";
      };

      tray = {
        spacing = 10;
        reverse-direction = true;
      };

      clock = {
        timezone = "Europe/Moscow";
        format = "<span font='14' rise='-2500' color='#${base07}'>󰥔 </span> {:%H:%M %p}";
        format-alt = "<span font='14' rise='-2500' color='#${base07}'> </span> {:%a, %d %b %Y}";
        interval = 10;
      };

      network = {
        interface = "wlp39s0f3u3";
        format = "{ifname}";
        format-wifi = "<span font='14' rise='-2500' color='#${base07}'> </span> {essid} ({signalStrength}%)";
        format-ethernet = "<span font='14' rise='-2500' color='#${base07}'>󰊗 </span> {ipaddr}/{cidr}";
        format-disconnected = "";
        max-length = 50;
      };

      battery = {
        format = "<span font='10' rise='0' color='#${base07}'>{icon}  </span> {capacity}%";
        format-charging = "<span font='10' rise='0' color='#${base07}'>󰂄  </span> {capacity}%";
        format-critical = "<span font='10' rise='0' color='#${base01}'>󰂃  </span> {capacity}%";
        interval = 15;
        states = {
          critical = 20;
        };
        format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
      };

      backlight = {
        format = "<span font='14' rise='-2500' color='#${base07}'>{icon}</span> {percent}%";
        format-icons = ["󰃞" "󰃟" "󰃝" "󰃠"];
        tooltip = false;
      };
      cpu = {
        format = "<span font='14' rise='-2500' color='#${base07}'> </span> {usage}%";
        tooltip = false;
      };

      memory = {
        format = "<span font='14' rise='-2500' color='#${base07}'> </span> {}%";
      };

      "group/group-audio" = {
        orientation = "inherit";
        drawer = {
          transition-duration = 500;
          children-class = "";
          transition-left-to-right = true;
        };
        tooltip = false;
        modules = [
          "pulseaudio"
          "pulseaudio/slider"
        ];
      };

      pulseaudio = {
        format = "<span font='16' rise='-2500' color='#${base07}'>{icon} </span> {volume}%";
        format-muted = "<span font='16' rise='-2500'>󰝟</span> Muted";
        format-icons = {
          default = ["" "" ""];
        };
        tooltip = false;
        on-click = "pamixer -t";
        ignored-sinks = ["Pro X Wireless Gaming Headset" "Starship/Matisse HD Audio Controller Digital Stereo (IEC958)" "PRO X Wireless Gaming Headset Analog Stereo" "PRO X Wireless Gaming Headset Digital Stereo"];
      };

      "pulseaudio/slider" = {
        min = 0;
        max = 100;
        orientation = "horizontal";
      };

      privacy = {
        icon-spacing = 10;
        icon-size = 14;
        transition-duration = 250;
        modules = [
          {
            type = "screenshare";
            tooltip = true;
            tooltip-icon-size = 14;
          }
          {
            type = "audio-out";
            tooltip = true;
            tooltip-icon-size = 14;
          }
          {
            type = "audio-in";
            tooltip = true;
            tooltip-icon-size = 14;
          }
        ];
      };

      "group/group-power" = {
        orientation = "inherit";
        drawer = {
          transition-duration = 500;
          children-class = "child-power";
          transition-left-to-right = false;
        };
        modules = [
          "custom/power"
          "custom/quit"
          # "custom/lock"
          "custom/reboot"
        ];
      };

      "custom/quit" = {
        format = "<span font='14' rise='-3000'>󰗼</span>";
        tooltip = false;
        on-click = "hyprctl dispatch exit";
      };

      "custom/power" = {
        format = "<span font='14' rise='-3000'></span>";
        tooltip = false;
        on-click = "shutdown now";
      };

      "custom/reboot" = {
        format = "<span font='14' rise='-3000'>󰜉</span>";
        tooltip = false;
        on-click = "reboot";
      };

      

    }];
  };
}