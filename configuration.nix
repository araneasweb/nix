{
  config,
  pkgs,
  inputs,
  prefs,
  lib,
  ...
}: {
  imports =
    [
      ./hardware-configuration.nix
      ./modules/nvf-config.nix
      ./modules/haskell.nix
      ./modules/rust.nix
      ./modules/reverse-engineering.nix
    ]
    ++ (lib.optional prefs.settings.useHyprland ./home/hyprland/hyprland.nix)
    ++ (lib.optional prefs.settings.useXmonad ./home/xmonad/xmonad.nix);

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  systemd = {
    services = {
      NetworkManager-wait-online.enable = false;
      greetd.serviceConfig = {
        Type = "idle";
        StandardInput = "tty";
        StandardOutput = "tty";
        StandardError = "journal";
        TTYReset = true;
        TTYVHangup = true;
        TTYVTDisallocate = true;
      };
    };
  };

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
  };

  networking = {
    hostName = "t480";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Vancouver";

  hardware.graphics.enable = true;

  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/aranea/.config/sops/age/keys.txt";
    secrets = {
      aranea_password = {
        neededForUsers = true;
      };
    };
  };

  programs = {
    thunar.enable = true;
    xfconf.enable = true;
    steam.enable = true;
    fish.enable = true;
    starship.enable = true;
    ssh.askPassword = "";
  };

  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          user = "aranea";
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember-session --remember";
        };
      };
    };
    tumbler.enable = true;
    printing.enable = true;
    libinput.enable = true;
    kmscon.enable = true;
    pulseaudio.enable = false;
    tlp.enable = true;
    udisks2.enable = true;
    gvfs.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };

  fonts = {
    packages = with pkgs.nerd-fonts; [
      hack
      arimo
      ubuntu-sans
    ];
    fontconfig = {
      defaultFonts = {
        serif = ["Arimo Nerd Font"];
        sansSerif = ["Arimo Nerd Font"];
        monospace = ["Hack Nerd Font"];
      };
    };
  };

  i18n = {
    defaultLocale = "en_CA.UTF-8";
    inputMethod = {
      enable = true;
      type = "ibus";
      ibus.engines = with pkgs.ibus-engines; [anthy];
    };
  };

  users.users.aranea = {
    isNormalUser = true;
    description = "aranea";
    extraGroups = ["networkmanager" "wheel" "podman" "vboxusers"];
    shell = pkgs.fish;
    hashedPasswordFile = config.sops.secrets.aranea_password.path;
    linger = true;
  };

  environment = {
    systemPackages = with pkgs; [
      inputs.zen-browser.packages.x86_64-linux.default
      brightnessctl
      busybox
      catppuccin-cursors.mochaMauve
      catppuccin-gtk
      catppuccin-kvantum
      catppuccin-papirus-folders
      cheese
      clang
      coq
      curl
      dconf
      (discord.override {withVencord = true;})
      (dyalog.override {acceptLicense = true;})
      fastfetch
      fd
      feh
      fzf
      gcc
      gdb
      gh
      git
      github-desktop
      glibc
      gnumake
      gnupg
      gparted
      htop
      hunspell
      hunspellDicts.en_CA
      hyfetch
      inetutils
      killall
      kitty
      krita
      lean4
      libreoffice-qt
      libselinux
      nasm
      nil
      nix-index
      nnn
      ocaml
      onefetch
      openjdk
      p11-kit
      pinentry-all
      pkg-config
      prismlauncher
      racket
      ranger
      ripgrep
      rustdesk
      swi-prolog-gui
      texlive.combined.scheme-full
      udiskie
      unzip
      upower
      util-linux
      valgrind
      vim
      vscode
      wget
      xarchiver
      xdg-user-dirs
      xorg.libX11
      zip
      zoom-us
    ];
    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = 1;
      XCURSOR_THEME = "catppuccin-mocha-mauve-cursors";
      XCURSOR_SIZE = "24";
      GTK_THEME = "catppuccin-mocha-mauve-standard";
      XDG_TERMINAL = "kitty";
      XDG_PICTURES_DIR = "Pictures";
      MANPAGER = "nvim +Man!";
      XCOMPOSEFILE = "${config.users.users.aranea.home}/.Xcompose";
      GTK_IM_MODULE = "ibus";
      QT_IM_MODULE = "ibus";
      XMODIFIERS = "@im=ibus";
    };
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 32 * 1024;
    }
  ];

  catppuccin.enable = true;

  console.font = "";

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      catppuccin-gtk = pkgs.catppuccin-gtk.override {
        accents = ["mauve"];
        size = "standard";
        variant = "mocha";
      };
      catppuccin-papirus-folders = pkgs.catppuccin-papirus-folders.override {
        accent = "mauve";
        flavor = "mocha";
      };
    };
  };

  security = {
    pki.certificates = [
      "/etc/ssl/certs/ubc_cert.crt"
    ];
    rtkit.enable = true;
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  system.stateVersion = "24.05";
}
