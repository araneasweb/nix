{
  config,
  pkgs,
  inputs,
  useHyprland,
  useXmonad,
  ...
}: {
  imports =
    [
      ./hardware-configuration.nix
      ./modules/nvf-config.nix
    ]
    ++ (
      if useHyprland
      then [./home/hyprland/hyprland.nix]
      else []
    )
    ++ (
      if useXmonad
      then [./home/xmonad/xmonad.nix]
      else []
    );

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  systemd.services = {
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
  i18n.defaultLocale = "en_CA.UTF-8";

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
    fish = {
      enable = true;
      shellInit = ''
        set -g fish_greeting ""
        function rungcc
            if test (count $argv) -eq 0
                echo "Usage: rungcc filename"
                return 1
            end
            set file $argv[1]
            set exe_name ".tmp_gcc"
            gcc $file -o $exe_name && ./$exe_name && rm $exe_name
        end
        function heval
          echo $argv | awk -v var="$argv" 'BEGIN {print "print $ " var}' | xargs -I {} ghc -e {}
        end
        alias "nfu"="sudo nix flake update --flake /etc/nixos/"
        alias "nrs"="sudo nixos-rebuild switch"
        alias ":q"=exit
        alias "cls"="clear && hyfetch"
        hyfetch
        alias "kimg"="kitty +kitten icat"
        alias "kdiff"="kitty +kitten diff"
        alias "kssh"="kitty +kitten ssh"
        alias "nixconf"="nvim /etc/nixos"
      '';
    };
    starship = {
      enable = true;
      settings = {
        character = {
          success_symbol = "[λ](bold green)";
          error_symbol = "[λ](bold red)";
        };
      };
    };
    ssh.askPassword = "";
  };

  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          user = "aranea";
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
    packages = with pkgs; [pkgs.nerd-fonts._0xproto pkgs.nerd-fonts.droid-sans-mono nerd-fonts.hack nerd-fonts.dejavu-sans-mono];
    fontconfig = {
      defaultFonts = {
        serif = ["DejaVu Nerd Font"];
        sansSerif = ["DejaVuSans Nerd Font"];
        monospace = ["DejaVuSansMono Nerd Font"];
      };
    };
  };

  users.users.aranea = {
    isNormalUser = true;
    description = "aranea";
    extraGroups = ["networkmanager" "wheel" "docker" "vboxusers"];
    shell = pkgs.fish;
    hashedPasswordFile = config.sops.secrets.aranea_password.path;
  };

  environment = {
    systemPackages = with pkgs; [
      inputs.zen-browser.packages.x86_64-linux.default
      tmux
      ghidra
      scanmem
      texlive.combined.scheme-full
      graphviz
      hyfetch
      dconf
      lean4
      ranger
      wget
      vim
      vscode
      fastfetch
      curl
      git
      htop
      gimp
      gparted
      mgba
      blender
      kitty
      kitty-themes
      catppuccin-gtk
      networkmanagerapplet
      gnupg
      pinentry-all
      brightnessctl
      catppuccin-cursors.mochaMauve
      catppuccin-kvantum
      catppuccin-papirus-folders
      killall
      nix-index
      go
      racket
      zoom-us
      unzip
      libreoffice-qt
      hunspell
      hunspellDicts.en_CA
      swi-prolog-gui
      gprolog
      github-desktop
      p11-kit
      nodejs_24
      (yarn.override {nodejs = null;})
      typescript
      (discord.override {withVencord = true;})
      xarchiver
      zip
      nnn
      ghc
      hlint
      cabal-install
      haskellPackages.haskell-language-server
      haskellPackages.tasty
      haskellPackages.hoogle
      haskellPackages.hakyll
      haskellPackages.QuickCheck
      haskellPackages.hoauth2
      haskellPackages.gloss
      haskellPackages.OpenGLRaw
      hpack
      electron
      feh
      gcc
      gnumake
      clang
      glibc
      gdu
      baobab
      udiskie
      stack
      onefetch
      R
      rPackages.languageserver
      python313
      ripgrep
      fd
      scala
      sbt
      gradle
      openjdk
      mitscheme
      miranda
      gh
      cargo
      rustc
      clippy
      rustfmt
      pkg-config
      util-linux
      libselinux
      fzf
      cheese
      coq
      upower
      ocaml
      stylish-haskell
      (dyalog.override {acceptLicense = true;})
      nasm
      inetutils
      gdb
      nushell
      wireshark
      valgrind
      krita
      prismlauncher
      xorg.libX11
      nil
      xdg-user-dirs
    ];
    sessionVariables = {
      XCURSOR_THEME = "catppuccin-mocha-mauve-cursors";
      XCURSOR_SIZE = "24";
      GTK_THEME = "catppuccin-mocha-mauve-standard";
      XDG_TERMINAL = "kitty";
      XDG_PICTURES_DIR = "Pictures";
      MANPAGER = "nvim +Man!";
      XCOMPOSEFILE = "${config.users.users.aranea.home}/.Xcompose";
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
    docker.enable = true;
  };

  system.stateVersion = "24.05";
}
