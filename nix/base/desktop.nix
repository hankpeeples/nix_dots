# this file contains shared config i want to have on desktop (gui) devices
{ config, pkgs, variables, host, hyprland-34-pkgs, vscode-extensions, ... }:
{
  # self-explaining one-liners
  boot.supportedFilesystems = [ "ntfs" "exfat" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # networking.firewall = {
  #   enable = true;
  #   allowedTCPPorts = [ variables.secrets.barrier.port ];
  #   allowedUDPPorts = [];
  # };

  boot.loader = {
    timeout = 3;
    efi = { 
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    #systemd-boot = {
    #  enable = true;
    #  configurationLimit = 7; # number of generations to show
    #};
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
      extraEntries = ''
      menuentry "Reboot" {
        reboot
      }
      menuentry "Poweroff" {
        halt
      } '';
    };
  };

  console = {
    earlySetup = true;
    keyMap = "us";
    colors = [
      "000000" "FC618D" "7BD88F" "FD9353" "5AA0E6" "948AE3" "5AD4E6" "F7F1FF"
      "99979B" "FB376F" "4ECA69" "FD721C" "2180DE" "7C6FDC" "37CBE1" "FFFFFF"
    ];
  };

  # sound with pipewire
  sound.enable = true;
  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  hardware.bluetooth = {
    enable = true;
    settings.General = {
      Experimental = "true"; # "enables dbus experimental interfaces"
      FastConnectable = "true"; # connect faster but draw more power
      Enable = "Control,Gateway,Headset,Media,Sink,Socket,Source"; # idk
    };
  };

  ##########################################
  ##########################################
  ################ PACKAGES ################
  ##########################################
  ##########################################

  # fonts to install
  fonts.packages = with pkgs; [
    noto-fonts # ~200 standard modern fonts for all kinds of languages
    noto-fonts-cjk-sans # for asian characters
    aileron # modern text with 16 variations
    # install only specific nerd fonts
    (nerdfonts.override { fonts = [
      "JetBrainsMono"
      "ProFont"
    ]; } )
  ];

  # packages to install
  environment.systemPackages = with pkgs; [
    ### gui
    firefox-devedition # browser
    unstable.alacritty # terminal
    kitty
    revive
    bottles # run windows software easily
    protonup-qt # easy ge-proton setup for steam
    variables.pkgs.gitnuro # newer version compared to nixpkgs
    ventoy # create bootable usb sticks
    unstable.resources # system monitor (best overall)
    monitor # system monitor (best process view)
    psensor # gui for (lm_)sensors to display system temperatures
    freefilesync # file backup
    vlc # video player
    baobab # disk usage analyzer
    unstable.vesktop # wayland optimized discord client
    spotify # PROPRIETARY
    obsidian # PROPRIETARY
    # sddm theme + dependency (login manager)
    variables.pkgs.sddm-sugar-candy
    libsForQt5.qt5.qtgraphicaleffects
    # gtk themes
    fluent-gtk-theme
    (orchis-theme.override { border-radius = 10; })
    (colloid-gtk-theme.override { tweaks = [ "normal" ]; })
    # icon themes
    gnome.adwaita-icon-theme # just having this installed fixes issues with some apps
    ((papirus-icon-theme.override { /*folder-*/color = "black"; })
      # replace default firefox icons with firefox developer edition icons
      .overrideAttrs (attrs: { postInstall = (attrs.postInstall or "") + ''
        ln -sf $out/share/icons/Papirus/16x16/apps/firefox-developer-icon.svg $out/share/icons/Papirus/16x16/apps/firefox.svg
        ln -sf $out/share/icons/Papirus/22x22/apps/firefox-developer-icon.svg $out/share/icons/Papirus/22x22/apps/firefox.svg
        ln -sf $out/share/icons/Papirus/24x24/apps/firefox-developer-icon.svg $out/share/icons/Papirus/24x24/apps/firefox.svg
        ln -sf $out/share/icons/Papirus/32x32/apps/firefox-developer-icon.svg $out/share/icons/Papirus/32x32/apps/firefox.svg
        ln -sf $out/share/icons/Papirus/48x48/apps/firefox-developer-icon.svg $out/share/icons/Papirus/48x48/apps/firefox.svg
        ln -sf $out/share/icons/Papirus/64x64/apps/firefox-developer-icon.svg $out/share/icons/Papirus/64x64/apps/firefox.svg
    ''; }))

    vscode

    ### cli
    playerctl # pause media with mpris
    lm_sensors # system temperature sensor info
    dunst # for better notify-send with dunstify

    ### only used without desktop environment
    font-manager
    copyq # clipboard manager
    networkmanagerapplet # tray icon for networking connection
    qview # image viewer
    audacious # audio player
    gnome.dconf-editor # needed for home-manager gtk theming
    gnome.gnome-disk-utility
    unstable.gnome.nautilus # file manager
    gnome.sushi # thumbnails in nautilus
    xarchiver # archive manager
    lxde.lxmenu-data # required to discover applications
    lxde.lxsession # just needed for lxpolkit (an authentication agent)
    alsa-utils # control volume

    ### only used on xorg
    lxappearance # manage gtk theming stuff if homemanager fails
    picom-jonaburg # compositor
    unclutter-xfixes # hide mouse on inactivity
    pick-colour-picker
    # could/should work on wayland, but doesnt for now :(
    # insomnia # rest api client
    # barrier # kvm switch
    gparted # partition manager

    ### only used on wayland
    socat # for hyprland workspaces with eww
    nwg-look # manage gtk theming stuff if homemanager fails
    wev ydotool # find out / send keycodes
    libsForQt5.qt5.qtwayland qt6.qtwayland # hyprland must-haves
    variables.pkgs.hyprctl-collect-clients # bring all clients to one workspace
    variables.pkgs.hyprsome # awesome-like workspaces
    unstable.hyprpicker # color picker
    unstable.swaynotificationcenter
    unstable.swww # wallpaper switching with animations
    unstable.eww # build custom widgets
    unstable.grim # whole screen screenshot
    unstable.grimblast # region select screenshot
    unstable.swayosd # osd for volume changes
    # lockscreen
    variables.pkgs.swaylock-effects
    unstable.swaylock-effects

    waybar
  ];

  ###########################################
  ###########################################
  ########### PROGRAMS / SERVICES ###########
  ###########################################
  ###########################################

  # xorg
  services.xserver = {
    enable = true;
    layout = config.console.keyMap;

    videoDrivers = [ "nvidia" ];

    # window manager / desktop environment
    # windowManager.awesome.enable = true;

    # display manager
    displayManager.defaultSession = "hyprland";
    displayManager.sddm = {
      enable = true;
      theme = "sugar-candy";
    };
  };

  services.flatpak.enable = true;

  # for configuring gaming mice with piper
  services.ratbagd.enable = true;

  # remove background noise from mic
  programs.noisetorch.enable = true;

  # necessary for swaylock-effects
  security.pam.services.swaylock = {};

  # needed for trash to work in nautilus
  services.gvfs.enable = true;

  # bluez bluetooth gui
  services.blueman.enable = true;

  # default application for opening directories
  xdg.mime.defaultApplications."inode/directory" = "nautilus.desktop";

  # for mounting usb sticks and stuff
  services.udisks2.enable = true;

  # shell alias for shorter fastfetch
  environment.shellAliases.fastfetch-short = "fastfetch -c /etc/dotfiles/fastfetch/short.jsonc";

  # qt theming (based on gtk theming)
  qt = {
    enable = true;
    style = "gtk2";
    platformTheme = "gtk2";
  };

  ### steam (PROPRIETARY)
  # programs.steam = {
  #   enable = true;
  #   package = pkgs.unstable.steam;
  # };
  # currently needs this
  nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];

  ### hyprland (tiling wayland compositor)
  # make chromium / electron apps use wayland
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    # version 0.34.0
          package = hyprland-34-pkgs.                   hyprland;
    portalPackage = hyprland-34-pkgs.xdg-desktop-portal-hyprland;
  };
  # use gtk desktop portal
  # (recommended for usage alongside hyprland desktop portal)
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  ############################################
  ############################################
  ############### HOME-MANAGER ###############
  ############################################
  ############################################
  home-manager.users."${variables.username}" = { config, ... }: {

  ### theming
  gtk.enable = true;
  # gtk theme
  gtk.theme.name = "Orchis-Dark";
  # icon theme
  gtk.iconTheme.name = "Papirus-Dark";
  # font config
  gtk.font.name = "Noto Sans";
  gtk.font.size = 10;
  # cursor theme
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 32;
  };
  gtk.cursorTheme = {
    name = "capitaine-cursors";
    size = 32;
  };

  # for play/pause current media player (and remembering last active player)
  services.playerctld.enable = true;

  # automatically mount usb sticks with notification and tray icon
  services.udiskie = {
    enable = true;
    automount = true;
    tray = "never"; # necessary when not having a tray
    notify = true;
  };

  # rofi (application launcher)
  programs.rofi = {
    enable = true;
    theme = "transparent"; # own theme
    package = pkgs.rofi-wayland; # wayland support
    terminal = "${pkgs.kitty}/bin/kitty";
  };

  # flameshot (screenshots on xorg)
  services.flameshot.enable = true;
  services.flameshot.settings.General = {
            uiColor  = "#FC618D";
    contrastUiColor  = "#5AD4E6";
    contrastOpacity  = 64;
    showHelp         = false;
    startupLaunch    = false;
    disabledTrayIcon = true;
  };

  ### create dotfiles
  # firefox (allow userChrome.css)
  home.file."./.mozilla/firefox/${host.firefoxProfile}/user.js".text = ''
    user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
  '';

  ### symlink dotfiles
  # files in ~/.config/
  xdg.configFile = {
    "nvim"                    = { source = config.lib.file.mkOutOfStoreSymlink "/etc/dotfiles/nvim";    recursive = true; };
    "helix"                   = { source = config.lib.file.mkOutOfStoreSymlink "/etc/dotfiles/helix";   recursive = true; };
    "eww"                     = { source = config.lib.file.mkOutOfStoreSymlink "/etc/dotfiles/eww";     recursive = true; };
    "awesome"                 = { source = config.lib.file.mkOutOfStoreSymlink "/etc/dotfiles/awesome"; recursive = true; };
    "waybar"                  = { source = config.lib.file.mkOutOfStoreSymlink "/etc/dotfiles/waybar";  recursive = true; };
    "kitty"                   = { source = config.lib.file.mkOutOfStoreSymlink "/etc/dotfiles/kitty";   recursive = true; };
    "swaync"                     .source = config.lib.file.mkOutOfStoreSymlink "/etc/dotfiles/swaync";
    "hypr/hyprland.conf"         .source = config.lib.file.mkOutOfStoreSymlink "/etc/dotfiles/hyprland/hyprland.conf";
    "fastfetch/config.jsonc"     .source = config.lib.file.mkOutOfStoreSymlink "/etc/dotfiles/fastfetch/default.jsonc";   
    "picom.conf"                 .source = config.lib.file.mkOutOfStoreSymlink "/etc/dotfiles/other/picom.conf";
    "copyq/copyq.conf"           .source = config.lib.file.mkOutOfStoreSymlink "/etc/dotfiles/other/copyq.conf";
  };
  # files somewhere else in ~/
  home.file = {
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "/etc/dotfiles/other/.zshrc";
    ".local/share/rofi/themes".source = config.lib.file.mkOutOfStoreSymlink "/etc/dotfiles/rofi";
    ".mozilla/firefox/${host.firefoxProfile}/chrome/userChrome.css".source = config.lib.file.mkOutOfStoreSymlink "/etc/dotfiles/other/firefox.css";
    ".local/share/fonts".source = config.lib.file.mkOutOfStoreSymlink "/etc/dotfiles/fonts";
  };
};}
