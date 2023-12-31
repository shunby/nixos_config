# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ] ++ [
      inputs.xremap.nixosModules.default
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixanami"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "ja_JP.UTF-8";
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };
  console.keyMap = "jp106";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  

  # xConfigure keymap in X11
  services.xserver.layout = "jp";
  services.xserver.xkbModel = "sun(type6jp)";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";
  
  services.xremap = {
    userName = "mikanami";
    serviceMode = "system";
    config = {
      modmap = [
        {
          remap = {
            Space = {
              held = "Space";
              alone = "F24";
            };
          };
        }
      ];

      virtual_modifiers = [
        "Muhenkan"
        "Space"
      ];

      keymap = [
        {
          remap = {
            Muhenkan-i = "Up";
            Muhenkan-j = "Left";
            Muhenkan-k = "Down";
            Muhenkan-l = "Right";
            Muhenkan-u = "Home";
            Muhenkan-o = "End";
            CapsLock = "BackSpace";
            F24 = "Space";

            Space-q = "Shift-1";
            Space-w = "Shift-Slash";
            Space-e = "Shift-2";
            Space-r = "Shift-7";
            Space-t = "Shift-3";

            Space-a = "Shift-Minus";
            Space-s = "Shift-Semicolon";
            Space-d = "Shift-8";
            Space-f = "Shift-9";
            Space-g = "Shift-Apostrophe";

            Space-z = "Ro";
            Space-x = "LeftBrace";
            Space-c = "RightBrace";
            Space-v = "BackSlash";
            Space-b = "Shift-5";

            Space-y = "Equal";
            Space-u = "Comma";
            Space-i = "Dot";
            Space-o = "Minus";
            Space-p = "Shift-6";
            Space-LeftBrace = "Shift-Yen";

            Space-h = "Shift-Equal";
            Space-j = "Shift-RightBrace";
            Space-k = "Shift-BackSlash";
            Space-l = "Semicolon";
            Space-Semicolon = "Shift-LeftBrace";

            Space-n = "Shift-4";
            Space-m = "Shift-Comma";
            Space-Comma = "Shift-Dot";
            Space-Dot = "Shift-Ro";
          };
        }
      ];
    };
  };
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mikanami = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      tree
      vscodium
    ];
    shell = pkgs.zsh;
  };

  # fonts
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
  ];

  programs = {
    zsh.enable = true;
  };

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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

