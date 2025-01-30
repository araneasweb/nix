{
  description = "aranea's little nix flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, lix-module, catppuccin, home-manager, zen-browser, ... }@inputs: {
    nixosConfigurations.t480 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        catppuccin.nixosModules.catppuccin
        home-manager.nixosModules.home-manager
        lix-module.nixosModules.default
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