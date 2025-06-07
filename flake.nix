{
  description = "aranea's little nix flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #impermanence.url = "github:nix-community/impermanence";
  };

  outputs = {
    nixpkgs,
    lix-module,
    catppuccin,
    home-manager,
    nvf,
    sops-nix,
    #impermanence,
    ...
  } @ inputs: let
    useHyprland = true;
  in {
    nixosConfigurations.t480 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs useHyprland;
      };
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        catppuccin.nixosModules.catppuccin
        home-manager.nixosModules.home-manager
        lix-module.nixosModules.default
        nvf.nixosModules.default
        sops-nix.nixosModules.sops
        #impermanence.nixosModules.impermanence
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.aranea = {
              imports =
                [
                  ./home/home.nix
                  catppuccin.homeModules.catppuccin
                  #impermanence.homeModules.impermanence
                ]
                ++ (
                  if useHyprland
                  then [./home/hyprland/hyprland_hm.nix]
                  else []
                );
            };
          };
        }
      ];
    };
  };
}
