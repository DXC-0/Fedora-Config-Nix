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
// This config is in the KDL format: https://kdl.dev
// "/-" comments out the following node.
// Check the wiki for a full description of the configuration:
// https://github.com/YaLTeR/niri/wiki/Configuration:-Introduction

// Input device configuration.
// Find the full list of options on the wiki:
// https://github.com/YaLTeR/niri/wiki/Configuration:-Input
input {
    keyboard {
        xkb {
               layout "fr"
        }

        // Enable numlock on startup, omitting this setting disables it
        numlock
    }

    // Next sections include libinput settings.
    // Omitting settings disables them, or leaves them at their default values.
    touchpad {
        // off
        tap
        // dwt
        // dwtp
        // drag false
        // drag-lock
        natural-scroll
        // accel-speed 0.2
        // accel-profile "flat"
        // scroll-method "two-finger"
        // disabled-on-external-mouse
    }

    mouse {
        // off
        // natural-scroll
        // accel-speed 0.2
        // accel-profile "flat"
        // scroll-method "no-scroll"
    }

    trackpoint {
        // off
        // natural-scroll
        // accel-speed 0.2
        // accel-profile "flat"
        // scroll-method "on-button-down"
        // scroll-button 273
        // middle-emulation
    }

    // Uncomment this to make the mouse warp to the center of newly focused windows.
    // warp-mouse-to-focus

    // Focus windows and outputs automatically when moving the mouse into them.
    // Setting max-scroll-amount="0%" makes it work only on windows already fully on screen.
    // focus-follows-mouse max-scroll-amount="0%"
}

environment {
	DISPLAY ":0"
}

// Applications Startup

spawn-at-startup "xwayland-satellite"
spawn-at-startup "swayidle"
spawn-at-startup "dunst"
spawn-at-startup "swaybg" "--image" "/home/alerion/wall.png"

// Screen Resolution

output "DP-1" {

    mode "3840x2160@239.99"
    scale 1.0
    transform "normal"
    position x=1280 y=0
}


// Layout Configuration

layout {
    // Set gaps around windows in logical pixels.

    gaps 25

    background-color "transparent"
    always-center-single-column
    center-focused-column "never"


    preset-column-widths {
        proportion 0.33333
        proportion 0.5
        proportion 0.66667
    }


    // New windows default width

    default-column-width { proportion 0.5; }


    // Focus Ring

    focus-ring {
        width 8
        active-color "#DA70D6"
        inactive-color "#DA70D6"
    }

    // Always visible border

    border {

        off
        width 4
        active-color "#FF00FF99"
        inactive-color "#FF00FF99"
        urgent-color "#FF00FF99"

    }

    // Windows Shadow

    shadow {

        on
        softness 40
        spread 4
        offset x=0 y=5
        color "#0007"
    }

}


// Animation settings.


animations {
    // Uncomment to turn off all animations.
    // off

    // Slow down all animations by this factor. Values below 1 speed them up instead.
    //slowdown 1.0
}


// Window Rules

window-rule {

    // This regular expression is intentionally made as specific as possible,

    match app-id=r#"^org\.wezfurlong\.wezterm$"#
    default-column-width {}
}

// Open the Firefox picture-in-picture player as floating by default.

window-rule {

    // Firefox Floating

    match app-id=r#"firefox$"# title="^Picture-in-Picture$"
    open-floating true
}

// Rounded Corners

window-rule {
    geometry-corner-radius 12
    clip-to-geometry true
}


layer-rule {
    // This is for swaybg; change for other wallpaper tools.
    // Find the right namespace by running niri msg layers.
    match namespace="^wallpaper$"
    place-within-backdrop true
}


// Optionally, disable the workspace shadows in the overview.
overview {
    workspace-shadow {
        off
    }
}


binds {

    Mod+Shift+Slash { show-hotkey-overlay; }
    Super+Alt+L hotkey-overlay-title="Lock the Screen: swaylock" { spawn "swaylock"; }

    Mod+I { spawn "sh" "-c" "grim -g \"$(slurp)\" - | wl-copy --type image/png"; }
    Mod+R { spawn "wofi" "--show" "drun"; }
    Mod+T hotkey-overlay-title="Open a Terminal: alacritty" { spawn "alacritty"; }
    Mod+W { close-window; }

    XF86AudioRaiseVolume allow-when-locked=true { spawn "ddcutil" "--bus=4" "setvcp" "10" "+" "10"; }
    XF86AudioLowerVolume allow-when-locked=true { spawn "ddcutil" "--bus=4" "setvcp" "10" "-" "10"; }
    XF86AudioMute        allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
    XF86AudioMicMute     allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

    Mod+O repeat=false { toggle-overview; }

    Mod+Left  { focus-column-left; }
    Mod+Down  { focus-window-down; }
    Mod+Up    { focus-window-up; }
    Mod+Right { focus-column-right; }
    Mod+H     { focus-column-left; }
    Mod+J     { focus-window-down; }
    Mod+K     { focus-window-up; }
    Mod+L     { focus-column-right; }

    Mod+Ctrl+Left  { move-column-left; }
    Mod+Ctrl+Down  { move-window-down; }
    Mod+Ctrl+Up    { move-window-up; }
    Mod+Ctrl+Right { move-column-right; }
    Mod+Ctrl+H     { move-column-left; }
    Mod+Ctrl+J     { move-window-down; }
    Mod+Ctrl+K     { move-window-up; }
    Mod+Ctrl+L     { move-column-right; }

    Mod+Home { focus-column-first; }
    Mod+End  { focus-column-last; }
    Mod+Ctrl+Home { move-column-to-first; }
    Mod+Ctrl+End  { move-column-to-last; }

    Mod+Shift+Left  { focus-monitor-left; }
    Mod+Shift+Down  { focus-monitor-down; }
    Mod+Shift+Up    { focus-monitor-up; }
    Mod+Shift+Right { focus-monitor-right; }
    Mod+Shift+H     { focus-monitor-left; }
    Mod+Shift+J     { focus-monitor-down; }
    Mod+Shift+K     { focus-monitor-up; }
    Mod+Shift+L     { focus-monitor-right; }

    Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
    Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
    Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
    Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
    Mod+Shift+Ctrl+H     { move-column-to-monitor-left; }
    Mod+Shift+Ctrl+J     { move-column-to-monitor-down; }
    Mod+Shift+Ctrl+K     { move-column-to-monitor-up; }
    Mod+Shift+Ctrl+L     { move-column-to-monitor-right; }

    Mod+Page_Down      { focus-workspace-down; }
    Mod+Page_Up        { focus-workspace-up; }
    Mod+U              { focus-workspace-down; }
    Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
    Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
    Mod+Ctrl+U         { move-column-to-workspace-down; }
    Mod+Ctrl+I         { move-column-to-workspace-up; }

    Mod+Shift+Page_Down { move-workspace-down; }
    Mod+Shift+Page_Up   { move-workspace-up; }
    Mod+Shift+U         { move-workspace-down; }
    Mod+Shift+I         { move-workspace-up; }

    Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
    Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
    Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
    Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

    Mod+WheelScrollRight      { focus-column-right; }
    Mod+WheelScrollLeft       { focus-column-left; }
    Mod+Ctrl+WheelScrollRight { move-column-right; }
    Mod+Ctrl+WheelScrollLeft  { move-column-left; }

    Mod+Shift+WheelScrollDown      { focus-column-right; }
    Mod+Shift+WheelScrollUp        { focus-column-left; }
    Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
    Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

    Mod+1 { focus-workspace 1; }
    Mod+2 { focus-workspace 2; }
    Mod+3 { focus-workspace 3; }
    Mod+4 { focus-workspace 4; }
    Mod+5 { focus-workspace 5; }
    Mod+6 { focus-workspace 6; }
    Mod+7 { focus-workspace 7; }
    Mod+8 { focus-workspace 8; }
    Mod+9 { focus-workspace 9; }
    Mod+Ctrl+1 { move-column-to-workspace 1; }
    Mod+Ctrl+2 { move-column-to-workspace 2; }
    Mod+Ctrl+3 { move-column-to-workspace 3; }
    Mod+Ctrl+4 { move-column-to-workspace 4; }
    Mod+Ctrl+5 { move-column-to-workspace 5; }
    Mod+Ctrl+6 { move-column-to-workspace 6; }
    Mod+Ctrl+7 { move-column-to-workspace 7; }
    Mod+Ctrl+8 { move-column-to-workspace 8; }
    Mod+Ctrl+9 { move-column-to-workspace 9; }

    Mod+BracketLeft  { consume-or-expel-window-left; }
    Mod+BracketRight { consume-or-expel-window-right; }

    Mod+Comma  { consume-window-into-column; }
    Mod+Period { expel-window-from-column; }

    Mod+Shift+R { switch-preset-window-height; }
    Mod+Ctrl+R { reset-window-height; }
    Mod+F { maximize-column; }
    Mod+Shift+F { fullscreen-window; }

    Mod+Ctrl+F { expand-column-to-available-width; }

    Mod+C { center-column; }

    Mod+Ctrl+C { center-visible-columns; }

    Mod+Minus { set-column-width "-10%"; }
    Mod+Equal { set-column-width "+10%"; }

    Mod+Shift+Minus { set-window-height "-10%"; }
    Mod+Shift+Equal { set-window-height "+10%"; }

    Mod+V       { toggle-window-floating; }
    Mod+Shift+V { switch-focus-between-floating-and-tiling; }

    Print { screenshot; }
    Ctrl+Print { screenshot-screen; }
    Alt+Print { screenshot-window; }

    Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }

    Mod+Shift+E { quit; }
    Ctrl+Alt+Delete { quit; }

    Mod+Shift+P { power-off-monitors; }
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

}
