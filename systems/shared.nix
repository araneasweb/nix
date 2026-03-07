{ config
, pkgs
, inputs
, prefs
, ...
}:
{
  imports = [
    ../modules/modules.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  systemd = {
    services = {
      NetworkManager-wait-online.enable = false;
      geoclue2 = {
        enable = true;
      };
    };
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      substituters = [
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };

  time.timeZone = "America/Vancouver";

  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/var/lib/sops-nix/key.txt";
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
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        zlib
        zstd
        stdenv.cc.cc
        curl
        openssl
        attr
        libssh
        bzip2
        libxml2
        acl
        libsodium
        util-linux
        xz
        systemd
        libXcomposite
        libXtst
        libXrandr
        libXext
        libX11
        libXfixes
        libGL
        libva
        pipewire
        libxcb
        libXdamage
        libxshmfence
        libXxf86vm
        libelf
        glib
        gtk2
        networkmanager
        vulkan-loader
        libgbm
        libdrm
        libxcrypt
        coreutils
        pciutils
        zenity
        glibc_multi.bin # Seems to cause issue in ARM
        libXinerama
        libXcursor
        libXrender
        libXScrnSaver
        libXi
        libSM
        libICE
        gnome2.GConf
        nspr
        nss
        cups
        libcap
        SDL2
        libusb1
        dbus-glib
        ffmpeg
        libudev0-shim
        gtk3
        icu
        libnotify
        gsettings-desktop-schemas
        libXt
        libXmu
        libogg
        libvorbis
        SDL
        SDL2_image
        glew_1_10
        libidn
        tbb
        flac
        freeglut
        libjpeg
        libpng
        libpng12
        libsamplerate
        libmikmod
        libtheora
        libtiff
        pixman
        speex
        SDL_image
        SDL_ttf
        SDL_mixer
        SDL2_ttf
        SDL2_mixer
        libappindicator-gtk2
        libdbusmenu-gtk2
        libindicator-gtk2
        libcaca
        libcanberra
        libgcrypt
        libvpx
        librsvg
        libXft
        libvdpau
        pango
        cairo
        atk
        gdk-pixbuf
        fontconfig
        freetype
        dbus
        alsa-lib
        expat
        libxkbcommon
        libxcrypt-legacy
        libGLU
        fuse
        e2fsprogs
      ];
    };
  };

  services = {
    tumbler.enable = true;
    printing.enable = true;
    libinput.enable = true;
    # kmscon.enable = true;
    pulseaudio.enable = false;
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
      wireplumber.enable = true;
    };
  };

  fonts = {
    packages = with pkgs; [
      hack-font-ligature-nerd
      nerd-fonts.arimo
      nerd-fonts.ubuntu-sans
      noto-fonts
    ];
    fontconfig = {
      defaultFonts = {
        serif = [
          "Arimo Nerd Font"
          "Noto Serif"
        ];
        sansSerif = [
          "Arimo Nerd Font"
          "Noto Sans"
        ];
        monospace = [
          "Hack Nerd Font Mono"
          "Noto Sans Mono"
        ];
      };
    };
  };

  i18n = {
    defaultLocale = "en_CA.UTF-8";
    inputMethod = {
      enable = true;
      type = "ibus";
      ibus.engines = with pkgs.ibus-engines; [
        anthy
        table
      ];
    };
  };

  users.users.${prefs.data.username} = {
    isNormalUser = true;
    description = prefs.data.username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "podman"
      "vboxusers"
    ];
    shell = pkgs.fish;
    hashedPasswordFile = config.sops.secrets.aranea_password.path;
    linger = true;
  };

  nosModules = {
    haskell.enable = true;
    rust.enable = false;
    digitalDesign.enable = false;
    reverseEngineering.enable = false;
    nvf.enable = false;
    gaming.enable = true;
  };

  environment = {
    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = 1;
      XCURSOR_THEME = "catppuccin-mocha-mauve-cursors";
      XCURSOR_SIZE = "24";
      GTK_THEME = "catppuccin-mocha-mauve-standard";
      XDG_TERMINAL = "ghostty";
      XDG_PICTURES_DIR = "Pictures";
      MANPAGER = "nvim +Man!";
      XCOMPOSEFILE = "${config.users.users.${prefs.data.username}.home}/.XCompose";
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

  catppuccin.enable = true;

  console = {
    font = "ter-112n";
    packages = [ pkgs.terminus_font ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      catppuccin-gtk = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
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

  system.stateVersion = "26.05";

}
