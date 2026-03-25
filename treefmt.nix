{ ... }:
{
  projectRootFile = "flake.nix";

  programs.nixfmt = {
    enable = true;
    width = 80;
  };
}
