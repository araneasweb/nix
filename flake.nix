{
  description = "aranea's little nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    catppuccin.url = "github:catppuccin/nix";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
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

    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      darwin,
      treefmt-nix,
      catppuccin,
      home-manager,
      sops-nix,
      ...
    }:
    let
      inherit (nixpkgs) lib;

      prefs = {
        data = {
          username = "aranea";
        };
      };

      username = prefs.data.username;

      hosts = import ./lib/hosts.nix;

      systems = lib.unique (map (host: host.system) (lib.attrValues hosts));
      forAllSystems = lib.genAttrs systems;

      isLinux = system: lib.hasSuffix "linux" system;
      isDarwin = system: lib.hasSuffix "darwin" system;

      treefmtEval = forAllSystems (
        system:
        treefmt-nix.lib.evalModule nixpkgs.legacyPackages.${system} ./treefmt.nix
      );

      overlays = [
        (import ./overlays/fonts.nix)
        (import ./overlays/catppuccin.nix)
        inputs.nix-alien.overlays.default
        inputs.nix-doom-emacs-unstraightened.overlays.default
      ];

      commonHomeModules = [
        ./home/default.nix
        ./home/programs/zen-browser.nix
        catppuccin.homeModules.catppuccin
        inputs.zen-browser.homeModules.beta
        inputs.nix-doom-emacs-unstraightened.homeModule
      ];

      homePlatformModules =
        system:
        lib.optionals (isLinux system) [ ./home/platform/linux.nix ]
        ++ lib.optionals (isDarwin system) [ ./home/platform/darwin.nix ];

      desktopProfiles = {
        hyprland = {
          systemModules = [ ./modules/nixos/desktops/hyprland.nix ];
          homeModules = [ ./home/desktops/hyprland/default.nix ];
        };

        xmonad = {
          systemModules = [ ./modules/nixos/desktops/xmonad.nix ];
          homeModules = [ ./home/desktops/xmonad/default.nix ];
        };

        cosmic = {
          systemModules = [ ./modules/nixos/desktops/cosmic.nix ];
          homeModules = [ ];
        };

        none = {
          systemModules = [ ];
          homeModules = [ ];
        };
      };

      pkgsModule = {
        nixpkgs = {
          inherit overlays;
          config.allowUnfree = true;
        };
      };

      mkHomeManagerModule =
        {
          host,
          extraHomeModules ? [ ],
        }:
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            extraSpecialArgs = {
              inherit inputs prefs host;
            };

            users.${username}.imports =
              commonHomeModules ++ homePlatformModules host.system ++ extraHomeModules;
          };
        };

      mkNixosHost =
        _: host:
        let
          desktopProfile = desktopProfiles.${host.desktop} or desktopProfiles.none;
        in
        lib.nixosSystem {
          inherit (host) system;

          specialArgs = {
            inherit inputs prefs host;
          };

          modules = [
            pkgsModule
            ./modules/shared/base.nix
            ./modules/nixos/base.nix
            ./modules/nixos/default.nix
            host.module

            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops

            (mkHomeManagerModule {
              inherit host;
              extraHomeModules = desktopProfile.homeModules;
            })
          ]
          ++ desktopProfile.systemModules;
        };

      mkDarwinHost =
        _: host:
        darwin.lib.darwinSystem {
          inherit (host) system;

          specialArgs = {
            inherit inputs prefs host;
          };

          modules = [
            pkgsModule
            ./modules/shared/base.nix
            ./modules/darwin/base.nix
            host.module

            home-manager.darwinModules.home-manager
            sops-nix.darwinModules.sops

            (mkHomeManagerModule {
              inherit host;
            })
          ];
        };

      nixosHosts = lib.filterAttrs (_: host: isLinux host.system) hosts;
      darwinHosts = lib.filterAttrs (_: host: isDarwin host.system) hosts;
    in
    {
      formatter = forAllSystems (system: treefmtEval.${system}.config.build.wrapper);

      checks = forAllSystems (system: {
        formatting = treefmtEval.${system}.config.build.check self;
      });

      nixosConfigurations = lib.mapAttrs mkNixosHost nixosHosts;
      darwinConfigurations = lib.mapAttrs mkDarwinHost darwinHosts;
    };
}
