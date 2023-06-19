# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  iconTheme = pkgs.breeze-icons.out;
  themeEnv = ''
    # QT: remove local user overrides (for determinism, causes hard to find bugs)
    rm -f ~/.config/Trolltech.conf

    # GTK3: remove local user overrides (for determinisim, causes hard to find bugs)
    rm -f ~/.config/gtk-3.0/settings.ini

    # GTK3: add breeze theme to search path for themes
    # (currently, we need to use gnome-breeze because the GTK3 version of kde5.breeze is broken)
    export XDG_DATA_DIRS="${pkgs.libsForQt5.breeze-gtk}/share:$XDG_DATA_DIRS"

    # GTK3: add /etc/xdg/gtk-3.0 to search path for settings.ini
    # We use /etc/xdg/gtk-3.0/settings.ini to set the icon and theme name for GTK 3
    export XDG_CONFIG_DIRS="/etc/xdg:$XDG_CONFIG_DIRS"

    # GTK2 theme + icon theme
    export GTK2_RC_FILES=${pkgs.writeText "iconrc" ''gtk-icon-theme-name="breeze"''}:${pkgs.breeze-gtk}/share/themes/Breeze/gtk-2.0/gtkrc:$GTK2_RC_FILES

    # SVG loader for pixbuf (needed for GTK svg icon themes)
    export GDK_PIXBUF_MODULE_FILE=$(echo ${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/*/loaders.cache)

    # QT5: convince it to use our preferred style
    export QT_STYLE_OVERRIDE=breeze
  '';
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "gb";
    xkbVariant = "";
  };

  programs.hyprland.enable = true;

  # Configure console keymap
  console.keyMap = "uk";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.addo = {
    isNormalUser = true;
    description = "Addo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "addo";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.extraInit = ''
    ${themeEnv}
  
    # these are the defaults, but some applications are buggy so we set them
    # here anyway
    export XDG_CONFIG_HOME=$HOME/.config
    export XDG_DATA_HOME=$HOME/.local/share
    export XDG_CACHE_HOME=$HOME/.cache
  '';
  
  # QT4/5 global theme
  environment.etc."xdg/Trolltech.conf" = {
    text = ''
      [Qt]
      style=Breeze
    '';
    mode = "444";
  };
  
  # GTK3 global theme (widget and icon theme)
  environment.etc."xdg/gtk-3.0/settings.ini" = {
    text = ''
      [Settings]
      gtk-icon-theme-name=breeze
      gtk-theme-name=Breeze-gtk
    '';
    mode = "444";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #(buildGoModule rec {
      #pname = "nwg-look";
      #version = "0.2.2";
#
      #src = fetchFromGitHub {
        #owner = "nwg-piotr";
        #repo = "nwg-look";
        #rev = "v${version}";
        #sha256 = "sha256-vrlTBjDPGsRyPqw3tghDplVDVhHqeya/nefg5zTmT0s=";
      #};
#
      #vendorHash = "sha256-5nsXSPjCinzJHtm/YsgJZ6xRlp7P4ArXC0jl1KomHPc=";
#
      #nativeBuildInputs = [ pkg-config ];
      #buildInputs = [ gtk3 gtk-layer-shell ];
#
      #postInstall = ''
        #mkdir -p $out/share/nwg-look/
        #cp -r langs $out/share/nwg-look/
      #'';
#
      #meta = with lib; {
        #description = "GTK3 settings editor strongly influenced by LXAppearance";
        #homepage = "https://github.com/nwg-piotr/nwg-look";
        #license = licenses.mit;
        #maintainers = with maintainers; [ "nwg-piotr" ];
        #platforms = platforms.all;
      #};
    #})
    gnumake
    cmake
    ninja
    go
    neovim
    tmux
    hyprland
    hyprpaper
    gtk3
    kitty
    firefox
    pkgs.jetbrains.clion
    glib # For gsettings
    lxappearance # For previewing themes
    xdg-utils # For opening default programs
    dracula-theme # GTK theme
    pkgs.catppuccin-gtk # GTK theme
    pkgs.catppuccin-cursors
    gnome3.adwaita-icon-theme
    pkgs.tmuxPlugins.catppuccin # Tmux theme
    grim # Screenshots
    slurp # Screenshots
    bemenu # dmenu for Wayland
    mako # Notifications
    wdisplays # Configure displays
    git
    cinnamon.nemo
    btop

    breeze-qt5
    breeze-gtk
    iconTheme
    gnome3.adwaita-icon-theme
    hicolor-icon-theme
  ];

  environment.pathsToLink = [ "/share" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
