{
  description = "aranea's little nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

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
    nvim-dots.url = "github:araneasweb/nvim-dots";

    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      treefmt-nix,
      catppuccin,
      home-manager,
      sops-nix,
      ...
    }:
    let
      inherit (nixpkgs) lib;

      systems = [
        "x86_64-linux"
      ];

      forAllSystems = lib.genAttrs systems;

      treefmtEval = forAllSystems (
        system:
        treefmt-nix.lib.evalModule nixpkgs.legacyPackages.${system} ./treefmt.nix
      );

      prefs = {
        data = {
          username = "aranea";
          treeDir = "/etc/nixos";
        };
      };

      username = prefs.data.username;

      overlays = [
        (import ./overlays/fonts.nix)
        (import ./overlays/catppuccin.nix)
        inputs.nix-alien.overlays.default
      ];

      commonHomeModules = [
        ./home/home.nix
        ./home/modules/zen-browser-hm.nix
        catppuccin.homeModules.catppuccin
        inputs.zen-browser.homeModules.beta
        inputs.nix-doom-emacs-unstraightened.homeModule
      ];

      desktopProfiles = {
        hyprland = {
          systemModules = [ ./home/hyprland/hyprland.nix ];
          homeModules = [ ./home/hyprland/hyprland_hm.nix ];
        };

        xmonad = {
          systemModules = [ ./home/xmonad/xmonad.nix ];
          homeModules = [ ./home/xmonad/xmonad_hm.nix ];
        };

        cosmic = {
          systemModules = [ ./home/cosmic/cosmic.nix ];
          homeModules = [ ];
        };

        none = {
          systemModules = [ ];
          homeModules = [ ];
        };
      };

      hosts = {
        t480 = {
          system = "x86_64-linux";
          desktop = "hyprland";
          module = ./systems/t480/t480.nix;
        };

        azalea = {
          system = "x86_64-linux";
          desktop = "cosmic";
          module = ./systems/azalea/azalea.nix;
        };
      };

      mkHomeManagerModule =
        {
          homeModules ? [ ],
        }:
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            extraSpecialArgs = {
              inherit inputs prefs;
            };

            users.${username}.imports = commonHomeModules ++ homeModules;
          };
        };

      mkHost =
        name: host:
        let
          desktopProfile = desktopProfiles.${host.desktop} or desktopProfiles.none;
        in
        lib.nixosSystem {
          inherit (host) system;

          specialArgs = {
            inherit inputs prefs;
          };

          modules = [
            {
              nixpkgs = {
                inherit overlays;
                config.allowUnfree = true;
              };
            }

            ./systems/shared.nix
            host.module

            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops

            (mkHomeManagerModule {
              homeModules = desktopProfile.homeModules;
            })
          ]
          ++ desktopProfile.systemModules;
        };
    in
    {
      formatter = forAllSystems (system: treefmtEval.${system}.config.build.wrapper);

      checks = forAllSystems (system: {
        formatting = treefmtEval.${system}.config.build.check self;
      });

      nixosConfigurations = lib.mapAttrs mkHost hosts;
    };
}
