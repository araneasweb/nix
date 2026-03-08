{
  description = "aranea's little nix flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    # hyprland-easymotion = {
    #   url = "github:zakk4223/hyprland-easymotion";
    #   inputs.hyprland.follows = "hyprland";
    # };
    catppuccin.url = "github:catppuccin/nix";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    xmonad-contexts = {
      url = "github:Procrat/xmonad-contexts";
      flake = false;
    };
    # lix-module = {
    #   url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.3-1.tar.gz";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    scrolleof-nvim = {
      url = "github:Aasim-A/scrollEOF.nvim";
      flake = false;
    };
    impermanence.url = "github:nix-community/impermanence";
    nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";
    doom-config = {
      url = "github:araneasweb/doom-config";
      flake = false;
    };
    nix-alien.url = "github:thiagokokada/nix-alien";
    nixcats-dots.url = "github:araneasweb/nixcats-dots";
  };
  outputs =
    { nixpkgs
    , # lix-module,
      catppuccin
    , home-manager
    , nvf
    , sops-nix
    , #impermanence,
      nixcats-dots
    , ...
    }@inputs:
    let
      inherit (nixpkgs) lib;
      prefs = {
        data = {
          username = "aranea";
          treeDir = "/etc/nixos";
        };
        settings = {
          useHyprland = true;
          useXmonad = false;
        };
      };
      overlays = [
        (import ./overlays/fonts.nix)
        inputs.nix-alien.overlays.default
      ];
    in
    {
      formatter = lib.genAttrs [ "x86_64-linux" ] (
        system: (import nixpkgs { inherit system; }).nixfmt
      );
      nixosConfigurations.t480 = lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs prefs;
        };
        modules = [
          { nixpkgs.overlays = overlays; }
          ./systems/t480/t480.nix
          ./systems/t480/hardware-configuration.nix
          #./impermanence.nix
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          # lix-module.nixosModules.default
          nvf.nixosModules.default
          sops-nix.nixosModules.sops
          #impermanence.nixosModules.impermanence
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs prefs;
              };
              users.${prefs.data.username} = {
                imports = [
                  ./home/home.nix
                  ./home/modules/zen-browser-hm.nix
                  catppuccin.homeModules.catppuccin
                  inputs.zen-browser.homeModules.beta
                  #impermanence.homeModules.impermanence
                  inputs.nix-doom-emacs-unstraightened.homeModule
                ]
                ++ (lib.optional prefs.settings.useHyprland ./home/hyprland/hyprland_hm.nix)
                ++ (lib.optional prefs.settings.useXmonad ./home/xmonad/xmonad_hm.nix);
              };
            };
          }
        ];
      };
      nixosConfigurations.azalea = lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs prefs;
        };
        modules = [
          { nixpkgs.overlays = overlays; }
          ./systems/azalea/azalea.nix
          ./systems/azalea/hardware-configuration.nix
          #./impermanence.nix
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          # lix-module.nixosModules.default
          nvf.nixosModules.default
          sops-nix.nixosModules.sops
          #impermanence.nixosModules.impermanence
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs prefs;
              };
              users.${prefs.data.username} = {
                imports = [
                  ./home/home.nix
                  ./home/modules/zen-browser-hm.nix
                  catppuccin.homeModules.catppuccin
                  inputs.zen-browser.homeModules.beta
                  #impermanence.homeModules.impermanence
                  inputs.nix-doom-emacs-unstraightened.homeModule
                ]
                ++ (lib.optional prefs.settings.useHyprland ./home/hyprland/hyprland_hm.nix)
                ++ (lib.optional prefs.settings.useXmonad ./home/xmonad/xmonad_hm.nix);
              };
            };
          }
        ];
      };
    };
}
