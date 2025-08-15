{ pkgs, ... }:

{
  home.username = "alerion";
  home.homeDirectory = "/home/alerion/";
  home.stateVersion = "20.09";

  targets.genericLinux.enable = true;
  xdg.enable = true;

  programs.alacritty = {
    enable = true;
    settings = {
      env = { TERM = "xterm-256color"; };
      window = {
        opacity = 1;
        decorations = "None";
        padding = { x = 10; y = 10; };
      };
      font = {
        size = 11;
        normal = {
          family = "monospace";
          style = "Regular";
        };
      };
      colors = {
        primary = { foreground = "0x00FF00"; };
        cursor = { text = "0x000000"; };
        selection = { text = "0x000000"; };
        normal = {
          black = "0x000000";
          red = "0xFF005F";
          green = "0x00FF00";
          yellow = "0xFFFF00";
          blue = "0x00FFFF";
          magenta = "0xFF00FF";
          cyan = "0x00FFFF";
          white = "0xC0C0C0";
        };
        bright = {
          black = "0x404040";
          red = "0xFF00AA";
          green = "0x00FF00";
          yellow = "0xFFFF5F";
          blue = "0x5F87FF";
          magenta = "0xFF77FF";
          cyan = "0x87FFFF";
          white = "0xFFFFFF";
        };
      };
      cursor = { style = "Beam"; };
      keyboard = {
        bindings = [
          { key = "V"; mods = "Control|Shift"; action = "Paste"; }
          { key = "C"; mods = "Control|Shift"; action = "Copy"; }
        ];
      };
      terminal = {
        shell = {
          program = "/bin/bash";
          args = [ "--login" ];
        };
      };
    };
  };


  programs.tmux = {
    enable = true;
    extraConfig = ''
      unbind C-b
      set-option -g prefix C-x
      bind-key C-x send-prefix

      # split panes
      bind a split-window -h
      bind z split-window -v
      unbind '"'
      unbind %

      # switch panes using Alt-arrow without prefix
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D
    '';
  };


  programs.wofi = {
    enable = true;
    settings = {
      hide_scroll = true;
      width = "30%";
      lines = 11;
      line_wrap = "word";
      term = "alacritty";
      allow_markup = true;
      always_parse_args = false;
      show_all = true;
      print_command = true;
      layer = "overlay";
      allow_images = true;
      sort_order = "default";
      gtk_dark = true;
      prompt = "";
      image_size = 35;
      display_generic = false;
      location = "center";
      key_expand = "Tab";
      insensitive = false;
      single_click = true;
    };
    style = ''
      * {
        font-family: JetBrainsMono, SpaceMono;
        color: #e5e9f0;
        font-size: 18px;
      }

      #window {
        margin: auto;
        padding: 10px;
        border-radius: 25px;
        border: 6px solid rgba(218, 112, 212, 1.0);
        background-color: #151515;
        opacity: 1.0;
      }

      #input {
        padding: 10px;
        margin-bottom: 10px;
        border-radius: 5px;
      }

      #outer-box {
        padding: 20px;
      }

      #img {
        margin-right: 6px;
      }

      #entry {
        padding: 10px;
        border-radius: 10px;
      }

      #entry:selected {
        background-color: rgba(218, 112, 212, 1.0);
      }

      #text {
        margin: 2px;
      }
    '';
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        frame_color = "#da70d4";
        frame_width = 5;
        separator_color = "frame";
        highlight = "#8aadf4";
        foreground = "#ffffff";
        background = "#000000";
        width = "(0,700)";
        notification_limit = 20;
        font = "14";
        min_icon_size = 800;
        corner_radius = 11;
        offset = "0x0";
      };
    };
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = "redhat";
      colors = [ "#ff69b4" ];
      modules = [
        { type = "title"; keyColor = "#ff69b4"; }
        { type = "separator"; keyColor = "#ff69b4"; }
        { type = "os"; keyColor = "#ff69b4"; }
        { type = "host"; keyColor = "#ff69b4"; }
        { type = "kernel"; keyColor = "#ff69b4"; }
        { type = "uptime"; keyColor = "#ff69b4"; }
        { type = "packages"; keyColor = "#ff69b4"; }
        { type = "shell"; keyColor = "#ff69b4"; }
        { type = "display"; keyColor = "#ff69b4"; }
        { type = "de"; keyColor = "#ff69b4"; }
        { type = "wm"; keyColor = "#ff69b4"; }
        { type = "wmtheme"; keyColor = "#ff69b4"; }
        { type = "theme"; keyColor = "#ff69b4"; }
        { type = "icons"; keyColor = "#ff69b4"; }
        { type = "font"; keyColor = "#ff69b4"; }
        { type = "cursor"; keyColor = "#ff69b4"; }
        { type = "terminal"; keyColor = "#ff69b4"; }
        { type = "terminalfont"; keyColor = "#ff69b4"; }
        { type = "cpu"; keyColor = "#ff69b4"; }
        { type = "gpu"; keyColor = "#ff69b4"; }
        { type = "memory"; keyColor = "#ff69b4"; }
        { type = "swap"; keyColor = "#ff69b4"; }
        { type = "disk"; keyColor = "#ff69b4"; }
        { type = "localip"; keyColor = "#ff69b4"; }
        { type = "battery"; keyColor = "#ff69b4"; }
        { type = "poweradapter"; keyColor = "#ff69b4"; }
        { type = "locale"; keyColor = "#ff69b4"; }
        { type = "break"; keyColor = "#ff69b4"; }
        { type = "colors"; keyColor = "#ff69b4"; }
      ];
    };
  };

  programs.freetube = {
    enable = true;
    settings = {
      allowDashAv1Formats = true;
      checkForUpdates = false;
      defaultQuality = "2160";
      baseTheme = "catppuccinMocha";
      fullscreen = false;
      maximised = false;
    };
  };

  home.file.".config/niri/config.kdl".text = ''
    input {
      keyboard {
        xkb {
          layout "fr"
        }
        numlock
      }
      touchpad {
        tap
        natural-scroll
      }
      mouse {}
      trackpoint {}
    }

    environment {
      DISPLAY ":0"
    }

    spawn-at-startup "xwayland-satellite"
    spawn-at-startup "swayidle"
    spawn-at-startup "dunst"
    spawn-at-startup "swaybg" "--image" "/home/alerion/wall.png"

    output "DP-1" {
      mode "3840x2160@239.99"
      scale 1.0
      transform "normal"
      position x=1280 y=0
    }

    layout {
      gaps 25
      background-color "transparent"
      always-center-single-column
      center-focused-column "never"
      preset-column-widths {
        proportion 0.33333
        proportion 0.5
        proportion 0.66667
      }
      default-column-width { proportion 0.5; }
      focus-ring {
        width 8
        active-color "#DA70D6"
        inactive-color "#DA70D6"
      }
      border {
        off
        width 4
        active-color "#FF00FF99"
        inactive-color "#FF00FF99"
        urgent-color "#FF00FF99"
      }
      shadow {
        on
        softness 40
        spread 4
        offset x=0 y=5
        color "#0007"
      }
    }

    animations {}

    window-rule {
      match app-id=r#"^org\.wezfurlong\.wezterm$"#
      default-column-width {}
    }

    window-rule {
      match app-id=r#"firefox$"# title="^Picture-in-Picture$"
      open-floating true
    }

    window-rule {
      geometry-corner-radius 12
      clip-to-geometry true
    }

    layer-rule {
      match namespace="^wallpaper$"
      place-within-backdrop true
    }

    overview {
      workspace-shadow {
        off
      }
    }

    binds {
      Mod+R { spawn "wofi" "--show" "drun"; }
      Mod+T { spawn "alacritty"; }
      Mod+W { close-window; }
      Mod+F { maximize-column; }
      Mod+Shift+F { fullscreen-window; }
      Mod+Ctrl+F { expand-column-to-available-width; }
      Mod+Shift+E { quit; }
      Ctrl+Alt+Delete { quit; }
      Mod+Shift+P { power-off-monitors; }
      Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }
      Print { screenshot; }
      Ctrl+Print { screenshot-screen; }
      Alt+Print { screenshot-window; }
    }
  '';

  home.file.".config/mimeapps.list".text = ''
    [Default Applications]
    # Vidéo
    video/mp4=vlc.desktop
    video/x-matroska=vlc.desktop
    video/x-msvideo=vlc.desktop
    video/webm=vlc.desktop

    # Audio
    audio/mpeg=vlc.desktop
    audio/x-wav=vlc.desktop
    audio/ogg=vlc.desktop

    # Navigateur web
    x-scheme-handler/http=librewolf.desktop
    x-scheme-handler/https=librewolf.desktop
    text/html=librewolf.desktop

    # Images
    image/jpeg=eog.desktop
    image/png=eog.desktop
    image/gif=eog.desktop
    image/webp=eog.desktop

    # Dossiers et fichiers
    inode/directory=nautilus.desktop
    application/pdf=librewolf.desktop
  '';

home.file.".config/lightdm/lightdm.conf".text = ''
  [LightDM]
  autologin-user=alerion
  autologin-user-timeout=0
  autologin-session=niri
  greeter-session=lightdm-gtk-greeter

  [Seat:*]
  autologin-user=alerion
  autologin-user-timeout=0
  autologin-session=niri
  greeter-session=lightdm-gtk-greeter

  [XDMCPServer]
  #enabled=false
  #port=177

  [VNCServer]
  #enabled=false
  #command=Xvnc
  #port=5900
'';

}
