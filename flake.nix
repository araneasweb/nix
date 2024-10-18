{
  description = "aranea's little nix flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, catppuccin, home-manager, ... }: {
    nixosConfigurations.t480 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        catppuccin.nixosModules.catppuccin
        home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.aranea = {
                imports = [
                    ./home.nix
                    catppuccin.homeManagerModules.catppuccin
                ];
            };
          }
      ];
    };
  };
}