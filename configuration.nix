{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking = {
    hostName = "t480";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";

  hardware.pulseaudio.enable = false;

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
        fastfetch
      '';
    };
    starship.enable = true;
    ssh.askPassword = "";
  };

  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
    };
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
    packages = with pkgs; [ nerdfonts ];
    fontconfig = {
      defaultFonts = {
        serif = [ "DejaVu Nerd Font" ];
        sansSerif = [ "DejaVuSans Nerd Font" ];
        monospace = [ "DejaVuSansMono Nerd Font" ];
      };
    };
  };

  users.users.aranea = {
    isNormalUser = true;
    description = "aranea";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
  };

  environment = {
    systemPackages = with pkgs; [
      wget
      vim
      neovim
      vscode
      emacs29-pgtk
      fastfetch
      thunderbird
      curl
      git
      htop
      gimp
      blender
      kitty
      kitty-themes
      which
      npins
      pkgs.gnome-tweaks
      catppuccin-gtk
      networkmanagerapplet
      wofi
      waybar
      hyprpaper
      brightnessctl
      hyprcursor
      catppuccin-cursors.mochaMauve
      catppuccin-kvantum
      nwg-look
      catppuccin-papirus-folders
      killall
      nix-index
      macchina
      cliphist
      wl-clipboard
      go
      racket
      zoom-us
      unzip
      libreoffice-qt
      hunspell
      hunspellDicts.en_CA
      cabal-install 
      ghc
      swiProlog
      gprolog
      github-desktop
      p11-kit
      nodejs_18
      (yarn.override { nodejs = null; })
      jetbrains.idea-ultimate
      typescript
      jetbrains.clion
      jetbrains.rust-rover
      discord
      xarchiver
      zip
      nnn
      hyprshot
      hlint
      acct
      haskellPackages.haskell-language-server
      appimage-run
      electron
      gnome-multi-writer
      feh
      gcc
      gnumake
      clang
      glibc.static
      glibc
      zed-editor
      gdu
      baobab
      udiskie
      haskellPackages.stack
      haskellPackages.hoogle
      haskellPackages.hakyll
      onefetch
      R
      rPackages.languageserver
      vimPlugins.nvchad
      python3
      ripgrep
      fd
      scala
      sbt
      gradle
      openjdk
      mitscheme
      miranda
      haskellPackages.stylish-haskell
      alpine
      rstudio
      gh
      cargo
      rustc
      clippy
      rustfmt
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };
    variables = {
      XCURSOR_THEME = "catppuccin-mocha-mauve-cursors";
      XCURSOR_SIZE = "24";
      HYPRCURSOR_THEME = "catppuccin-mocha-mauve-cursors";
      HYPRCURSOR_SIZE = "24";
      GTK_THEME = "catppuccin-mocha-mauve-standard";
    };
  };

  swapDevices = [{
    device = "/swapfile";
    size = 32 * 1024;
  }];

  catppuccin.enable = true;

  console.font = "";

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
  };

  virtualisation.docker.enable = true;

  system.stateVersion = "24.05";

}
