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
      ./modules/modules.nix
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
      geoclue2 = {
        enable = true;
      };
    };
  };

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      substituters = [
        "https://hyprland.cachix.org"
        "https://vicinae.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
      ];
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
    age.keyFile = "/home/${prefs.data.username}/.config/sops/age/keys.txt";
    secrets = {
      aranea_password = {
        neededForUsers = true;
      };
    };
  };

  programs = {
    fish.enable = true;
    ssh.askPassword = "";
    starship.enable = true;
    thunar.enable = true;
    xfconf.enable = true;
  };

  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          user = prefs.data.username;
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember-session --remember";
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
      jack.enable = true;
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

  users.users.${prefs.data.username} = {
    isNormalUser = true;
    description = prefs.data.username;
    extraGroups = ["networkmanager" "wheel" "podman" "vboxusers"];
    shell = pkgs.fish;
    hashedPasswordFile = config.sops.secrets.aranea_password.path;
    linger = true;
  };

  nosModules = {
    haskell.enable = true;
    rust.enable = false;
    digitalDesign.enable = false;
    reverseEngineering.enable = false;
    nvf.enable = true;
    gaming.enable = true;
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
      erlang
      universal-ctags
      coq
      curl
      dconf
      vesktop
      fastfetch
      fd
      feh
      fzf
      gcc
      gdb
      gh
      ghostty
      git
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
      lazygit
      lean4
      libreoffice-qt
      libselinux
      libqalculate
      man-pages
      man-pages-posix
      nil
      nixfmt-rfc-style
      nix-index
      nix-your-shell
      onefetch
      openjdk
      p11-kit
      pinentry-all
      racket
      ripgrep
      sioyek
      spotify
      swi-prolog-gui
      texlive.combined.scheme-full
      tmux
      udiskie
      unzip
      upower
      util-linux
      valgrind
      vim
      wget
      xarchiver
      xdg-user-dirs
      xorg.libX11
      yazi
      zip
      zoom-us
    ];
    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = 1;
      XCURSOR_THEME = "catppuccin-mocha-mauve-cursors";
      XCURSOR_SIZE = "24";
      GTK_THEME = "catppuccin-mocha-mauve-standard";
      XDG_TERMINAL = "ghostty";
      XDG_PICTURES_DIR = "Pictures";
      MANPAGER = "nvim +Man!";
      XCOMPOSEFILE = "${config.users.users.${prefs.data.username}.home}/.Xcompose";
      GTK_IM_MODULE = "ibus";
      QT_IM_MODULE = "ibus";
      XMODIFIERS = "@im=ibus";
      INPUT_METHOD = "ibus";
      EDITOR = "nvim";
    };
  };

  documentation = {
    man = {
      generateCaches = false;
    };
    dev.enable = true;
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
    polkit.enable = true;
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  system.stateVersion = "24.05";
}
