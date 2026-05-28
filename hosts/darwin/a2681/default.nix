{ ... }:
{
  security = {
    pam.services.sudo_local.touchIdAuth = true;
  };

  time.timeZone = "America/Vancouver";

  system = {
    stateVersion = 6;
    defaults = {
      dock = {
        autohide = true;
        show-recents = false;
      };

      finder = {
        _FXShowPosixPathInTitle = true;
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
        QuitMenuItem = true;
        ShowPathbar = true;
        ShowStatusBar = true;
      };

      NSGlobalDomain = {
        "com.apple.swipescrolldirection" = true;
        "com.apple.sound.beep.feedback" = 1;
        AppleInterfaceStyle = "Dark";
        AppleKeyboardUIMode = 3;
        ApplePressAndHoldEnabled = false;

        InitialKeyRepeat = 15;
        KeyRepeat = 3;

        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
      };

      CustomUserPreferences = {
        NSGlobalDomain = {
          WebKitDeveloperExtras = true;
          AppleWindowRounding = 0;
        };
        "com.apple.screencapture" = {
          location = "~/Pictures";
          type = "png";
        };
        "com.apple.spaces" = {
          "spans-displays" = 0;
        };
        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.ImageCapture".disableHotPlug = true;
        loginwindow = {
          GuestEnabled = false;
          SHOWFULLNAME = true;
        };
        "com.apple.dock" = {
          "workspaces-auto-swoosh" = 0;
        };
        keyboard = {
          enableKeyMapping = true;
          remapCapsLockToEscape = true;
        };
      };
    };
  };
}
