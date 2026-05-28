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

    brews = [
      "coreutils"
    ];

    casks = [
      "calibre"
      "firefox"
      "ghostty"
      "helium-browser"
      "krita"
      "prismlauncher"
      "proton-pass"
      "protonvpn"
      "qutebrowser"
      "racket"
      "raycast"
      "slack"
      "spotify"
      "steam"
      "vesktop"
      "waterfox"
      "zoom"
    ];
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
  };
}
