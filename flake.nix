{
  description = "aranea's little nix flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    #lix-module = {
    #  url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    #lix-module,
    catppuccin,
    home-manager,
    nvf,
    sops-nix,
    ...
  } @ inputs: {
    nixosConfigurations.t480 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        catppuccin.nixosModules.catppuccin
        home-manager.nixosModules.home-manager
        #lix-module.nixosModules.default
        nvf.nixosModules.default
        sops-nix.nixosModules.sops
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.aranea = {
              imports = [
                ./home.nix
                catppuccin.homeModules.catppuccin
              ];
            };
          };
        }
      ];
    };
  };
}
