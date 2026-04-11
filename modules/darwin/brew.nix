{ config, inputs, ... }:

{
  system.primaryUser = "aranea";

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "aranea";
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };
    mutableTaps = false;
  };

  homebrew = {
    enable = true;
    user = "aranea";
    taps = builtins.attrNames config.nix-homebrew.taps;
    casks = [
      "firefox"
      "protonvpn"
      "ghostty"
      "qutebrowser"
    ];
  };
}
