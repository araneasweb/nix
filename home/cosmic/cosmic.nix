{ ... }: {
  services = {
    system76-scheduler = {
      enable = true;
    };
    displayManager = {
      cosmic-greeter = {
        enable = true;
      };
    };
    desktopManager = {
      cosmic = {
        enable = true;
      };
    };
  };
  environment = {
    sessionVariables = {
      COSMIC_DATA_CONTROL_ENABLED = 1;
    };
  };
}
