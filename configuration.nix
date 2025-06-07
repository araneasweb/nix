{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/nvf-config.nix
    ./home/hyprland.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  systemd.services.NetworkManager-wait-online.enable = false;

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
    systemPackages = [
      inputs.zen-browser.packages.x86_64-linux.default
      pkgs.tmux
      pkgs.ghidra
      pkgs.scanmem
      pkgs.graphviz
      pkgs.hyfetch
      pkgs.lean4
      pkgs.ranger
      pkgs.wget
      pkgs.vim
      pkgs.vscode
      pkgs.fastfetch
      pkgs.curl
      pkgs.git
      pkgs.htop
      pkgs.gimp
      pkgs.gparted
      pkgs.mgba
      pkgs.blender
      pkgs.kitty
      pkgs.kitty-themes
      pkgs.which
      pkgs.catppuccin-gtk
      pkgs.networkmanagerapplet
      pkgs.gnupg
      pkgs.pinentry-all
      pkgs.brightnessctl
      pkgs.catppuccin-cursors.mochaMauve
      pkgs.catppuccin-kvantum
      pkgs.catppuccin-papirus-folders
      pkgs.killall
      pkgs.nix-index
      pkgs.go
      pkgs.racket
      pkgs.zoom-us
      pkgs.unzip
      pkgs.libreoffice-qt
      pkgs.hunspell
      pkgs.hunspellDicts.en_CA
      pkgs.swi-prolog-gui
      pkgs.gprolog
      pkgs.github-desktop
      pkgs.p11-kit
      pkgs.nodejs_24
      (pkgs.yarn.override {nodejs = null;})
      pkgs.typescript
      (pkgs.discord.override {withVencord = true;})
      pkgs.xarchiver
      pkgs.zip
      pkgs.nnn
      pkgs.ghc
      pkgs.hlint
      pkgs.cabal-install
      pkgs.haskellPackages.haskell-language-server
      pkgs.haskellPackages.tasty
      pkgs.haskellPackages.hoogle
      pkgs.haskellPackages.hakyll
      pkgs.haskellPackages.QuickCheck
      pkgs.haskellPackages.hoauth2
      pkgs.haskellPackages.gloss
      pkgs.haskellPackages.OpenGLRaw
      pkgs.hpack
      pkgs.electron
      pkgs.feh
      pkgs.gcc
      pkgs.gnumake
      pkgs.clang
      pkgs.glibc
      pkgs.gdu
      pkgs.baobab
      pkgs.udiskie
      pkgs.stack
      pkgs.onefetch
      pkgs.R
      pkgs.rPackages.languageserver
      pkgs.python313
      pkgs.ripgrep
      pkgs.fd
      pkgs.scala
      pkgs.sbt
      pkgs.gradle
      pkgs.openjdk
      pkgs.mitscheme
      pkgs.miranda
      pkgs.gh
      pkgs.cargo
      pkgs.rustc
      pkgs.clippy
      pkgs.rustfmt
      pkgs.pkg-config
      pkgs.util-linux
      pkgs.libselinux
      pkgs.fzf
      pkgs.cheese
      pkgs.coq
      pkgs.upower
      pkgs.ocaml
      pkgs.stylish-haskell
      (pkgs.dyalog.override {acceptLicense = true;})
      pkgs.nasm
      pkgs.inetutils
      pkgs.gdb
      pkgs.nushell
      pkgs.wireshark
      pkgs.valgrind
      pkgs.krita
      pkgs.prismlauncher
      pkgs.xorg.libX11
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
