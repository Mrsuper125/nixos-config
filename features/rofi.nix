{
  pkgs,
  lib,
  config,
  ...
}: with lib; {
    home.file."/home/alex/.config/rofi/config.rasi" = with config.colorScheme.palette; {
      
      text = ''
      configuration {
        display-drun: ">";
        display-clipboard: ">";
        display-emoji: ">";
        drun-display-format: "{name}";
        modi: "drun";
      }

      * {
        font: "JetbrainsMono Nerd Font 14";

        background-color: #${base01};
        separatorcolor: transparent;

        border: 0;
        margin: 0;
        padding: 0;
        spacing: 0;	
      }

      window {
        width: 420px;
        border-radius: 15;
        border: 0;
        padding: 0;
        background-color: #${base01};
      }

      mainbox {
        background-color: #${base01};
        children: [inputbar,listview];
        padding: 10;
      }

      listview {
        scrollbar: false;
        padding: 2 0;
        background-color: #${base01};
        columns: 1;
        lines: 7;
        margin: 8 0 0 0;
      }


      inputbar {
        children: [prompt, entry];
        background-color: @background-alt;
        border-radius: 0;
      }

      prompt {
        font: "JetbrainsMono Nerd Font 20";
        background-color: #${base01};
        text-color: @accent;
        enabled: true;
        border-radius: 0;
        padding: -2 10 0 10;
      }

      entry {
        background-color: transparent;
        text-color: #${base05};
        placeholder-color: #${base05};
        border-radius: 0;
        placeholder: "Search...";
        blink: false;
        padding: 4;
      }

      element {
        background-color: rgba(0,0,0,0);
        padding: 10;
        border-radius: 5;
      }

      element-text {
        background-color: inherit;
        text-color: inherit;
        expand: true;
        horizontal-align: 0;
        vertical-align: 0.5;
      }

      element-icon {
        background-color: inherit;
        text-color: inherit;
        padding: 0 10 0 0;
      }

      element.normal.normal {
        background-color: #${base01};
        text-color: #${base05};
      }
      element.normal.urgent {
        background-color: @accent;
        text-color: #${base05};
      }
      element.normal.active {
        background-color: @accent;
        text-color: #${base05};
      }
      element.selected.normal {
        background-color: #${base02};
        text-color: #${base05};
      }
      element.selected.urgent {
        background-color: #${base01};
        text-color: #${base05};
      }
      element.selected.active {
        background-color: #${base02};
        text-color:	#${base05};
      }
      element.alternate.normal {
        background-color: #${base01};
        text-color: #${base05};
      }
      element.alternate.urgent {
        background-color: #${base01};
        text-color: #${base05};
      }
      element.alternate.active {
        background-color: #${base01};
        text-color: #${base05};
      }
    ''; 

    
  };

  programs.rofi = with config.colorScheme.palette; {
      enable = true;
      package = pkgs.rofi-wayland;
      
      theme = "/home/alex/.config/rofi/config.rasi";
    };  
}