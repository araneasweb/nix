{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    nosModules.haskell.enable = lib.mkEnableOption "enables haskell";
  };

  config = lib.mkIf config.nosModules.haskell.enable {
    environment.systemPackages = with pkgs; [
      ghc
      cabal-install
      stack
      stylish-haskell
      hpack
      haskell-language-server
      hlint
      ormolu
      haskellPackages.hoogle
      haskellPackages.ghcid
      haskellPackages.implicit-hie
      haskellPackages.cabal-gild
    ];

    environment.variables = {
      STACK_SYSTEM_GHC = "1";
    };

    programs.direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };
  };
}
