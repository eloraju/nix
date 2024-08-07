
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:
 {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./wm.nix
      ./shell/zsh.nix
      #<home-manager/nixos>
    ];

  # Make sure flakes are enabled
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Enable non-free (as in closed source) packages
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "carbon"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Helsinki";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     useXkbConfig = true; # use xkbOptions in tty.
   };

  # Configure services
  services = {
    # Enable the OpenSSH daemon.
    openssh.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable bluetooth service
    blueman.enable = true;

    # Enable Upower
    upower.enable = true;

    # Enable xbanish
    xbanish.enable = true;

    # Enable and configure X11
    xserver = {
      enable = true;
      xkb = {
        options = "eurosign:e,ctrl:nocaps";
	      layout = "fi";
	    };

      displayManager = {
        lightdm = {
          enable = true;
          greeter.enable = true;
        };
      };
    };

    # Fingerprint sensor
#    fprintd = {
#      enable = true;
#      tod = {
#        enable = true;
#        driver = pkgs.libfprint-2-tod1-vfs0090;
#        # Alternative driver
#        # driver = pkgs.libfprint-2-tod1-goodix;
#      };
#    };

    # Enable touchpad support (enabled by default in most desktopManagers).
    libinput.enable = true;
    
  };


  # Enable sound.
  sound.enable = true;
  # Bluetooth
  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      extraConfig = "load-module module-switch-on-connect";
    };
    bluetooth.enable = true;
    bluetooth.settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.juuso = {
    isNormalUser = true;
    extraGroups = [ 
    "wheel"
    "docker"
    "networkmanager"
    ];
    shell = pkgs.zsh;
   # User spesific packages
   # packages = with pkgs; [
   # ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    _1password
    _1password-gui
    alacritty
    bat
    brave
    btop
    curl
    docker
    eza
    fd
    flameshot
    fzf
    gcc
    gh
    git
    libgcc
    neovim
    oh-my-posh
    pavucontrol
    rofi
    rofi
    starship
    stow
    tmux
    unzip
    variety
    wget
    xbanish
    xclip
    xfce.thunar
    zsh
  ];

  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
    zsh.enable = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    nm-applet.enable = true;
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "juuso" ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  # HOME MANAGER
   # home-manager.useGlobalPkgs = true;
   # home-manager.useUserPackages = true;
   # home-manager.users.juuso = {
   #   /* The home.stateVersion option does not have a default and must be set */
   #   home.stateVersion = "23.05";
   #   programs = {
   #     git = {
   #       userName = "Juuso Elo-Rauta";
   #       userEmail = "juuso.er@gmail.com";
   #     };
   #   };
   # };
}

