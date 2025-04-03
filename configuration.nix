{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./nvf-config.nix
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

  programs = {
    hyprland.enable = true;
    firefox.enable = true;
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
        alias ":q"=exit
        alias "cls"="clear && hyfetch"
        # alias "heval"="read i | awk -v var="$i" 'BEGIN { print "print $ " var}' | xargs -d \n -I {} ghc -e {}" -- broken fix later
        hyfetch
      '';
    };
    starship = {
      enable = true;
    };

    ssh.askPassword = "";
  };

  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
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
  };

  environment = {
    systemPackages = [
      inputs.zen-browser.packages.x86_64-linux.default
      pkgs.tmux
      pkgs.xorg.xlsclients
      pkgs.ghostty
      pkgs.hyfetch
      pkgs.links2
      pkgs.lean4
      pkgs.ranger
      pkgs.st
      pkgs.tree
      pkgs.dig
      pkgs.SDL2
      pkgs.wget
      pkgs.vim
      pkgs.vscode
      pkgs.fastfetch
      pkgs.thunderbird
      pkgs.curl
      pkgs.git
      pkgs.htop
      pkgs.gimp
      pkgs.blender
      pkgs.kitty
      pkgs.kitty-themes
      pkgs.which
      pkgs.npins
      pkgs.pkgs.gnome-tweaks
      pkgs.catppuccin-gtk
      pkgs.networkmanagerapplet
      pkgs.wofi
      pkgs.waybar
      pkgs.hyprpaper
      pkgs.brightnessctl
      pkgs.hyprcursor
      pkgs.catppuccin-cursors.mochaMauve
      pkgs.catppuccin-kvantum
      pkgs.catppuccin-papirus-folders
      pkgs.killall
      pkgs.nix-index
      pkgs.macchina
      pkgs.cliphist
      pkgs.wl-clipboard
      pkgs.go
      pkgs.racket
      pkgs.zoom-us
      pkgs.unzip
      pkgs.libreoffice-qt
      pkgs.hunspell
      pkgs.hunspellDicts.en_CA
      pkgs.cabal-install
      pkgs.ghc
      pkgs.swi-prolog-gui
      pkgs.gprolog
      pkgs.github-desktop
      pkgs.p11-kit
      pkgs.nodejs_18
      (pkgs.yarn.override {nodejs = null;})
      pkgs.jetbrains.idea-ultimate
      pkgs.typescript
      (pkgs.discord.override {withVencord = true;})
      pkgs.xarchiver
      pkgs.zip
      pkgs.nnn
      pkgs.hyprshot
      pkgs.hlint
      pkgs.acct
      pkgs.haskellPackages.haskell-language-server
      pkgs.electron
      pkgs.gnome-multi-writer
      pkgs.feh
      pkgs.gcc
      pkgs.gnumake
      pkgs.clang
      pkgs.glibc.static
      pkgs.glibc
      pkgs.gdu
      pkgs.baobab
      pkgs.udiskie
      pkgs.stack
      pkgs.haskellPackages.hoogle
      pkgs.haskellPackages.hakyll
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
      pkgs.haskellPackages.stylish-haskell
      pkgs.gh
      pkgs.cargo
      pkgs.rustc
      pkgs.clippy
      pkgs.rustfmt
      pkgs.haskellPackages.hoauth2
      pkgs.zlib
      pkgs.haskellPackages.zlib
      pkgs.hpack
      pkgs.pkg-config
      pkgs.glib
      pkgs.pcre2
      pkgs.haskellPackages.QuickCheck
      pkgs.cairo
      pkgs.freetype
      pkgs.expat
      pkgs.fontconfig
      pkgs.util-linux
      pkgs.harfbuzz
      pkgs.libselinux
      pkgs.libsepol
      pkgs.gtk3
      pkgs.fzf
      pkgs.neo-cowsay
      pkgs.cheese
      pkgs.logisim
      pkgs.postman
      pkgs.obs-studio
      pkgs.haskellPackages.gloss
      pkgs.libGLU
      pkgs.freeglut
      pkgs.libglvnd
      pkgs.coq
      pkgs.haskellPackages.OpenGLRaw
      pkgs.upower
      pkgs.ocaml
      pkgs.glfw
      pkgs.xorg.libXxf86vm
      pkgs.mesa
      pkgs.floorp-unwrapped
      pkgs.stylish-haskell
      pkgs.haskellPackages.regex-tdfa
      pkgs.libdrm
      (pkgs.dyalog.override {acceptLicense = true;})
      pkgs.nasm
      pkgs.inetutils
      pkgs.gdb
      pkgs.nushell
      pkgs.deluge
      pkgs.wireshark
      pkgs.valgrind
      pkgs.krita
      pkgs.carapace
      pkgs.prismlauncher
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
      XCURSOR_THEME = "catppuccin-mocha-mauve-cursors";
      XCURSOR_SIZE = "24";
      HYPRCURSOR_THEME = "catppuccin-mocha-mauve-cursors";
      HYPRCURSOR_SIZE = "24";
      GTK_THEME = "catppuccin-mocha-mauve-standard";
      XDG_TERMINAL = "kitty";
      XDG_PICTURES_DIR = "Pictures";
      MANPAGER = "nvim +Man!";
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
