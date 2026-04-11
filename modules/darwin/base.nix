{
  pkgs,
  prefs,
  host,
  ...
}:
{
  nixpkgs.hostPlatform = host.system;

  users.users.${prefs.data.username} = {
    name = prefs.data.username;
    home = "/Users/${prefs.data.username}";
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  services.aerospace = {
    enable = true;
    settings = {
      config-version = 2;
      persistent-workspaces = [
        "1"
        "2"
        "3"
        "4"
        "5"
        "6"
        "7"
        "8"
        "9"
        "10"
      ];
      on-focus-changed = [ "move-mouse window-lazy-center" ];
      mode.main.binding = {
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";
        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";
        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-7 = "workspace 7";
        alt-8 = "workspace 8";
        alt-9 = "workspace 9";
        alt-0 = "workspace 10";
        alt-shift-1 = [
          "move-node-to-workspace 1"
          "workspace 1"
        ];
        alt-shift-2 = [
          "move-node-to-workspace 2"
          "workspace 2"
        ];
        alt-shift-3 = [
          "move-node-to-workspace 3"
          "workspace 3"
        ];
        alt-shift-4 = [
          "move-node-to-workspace 4"
          "workspace 4"
        ];
        alt-shift-5 = [
          "move-node-to-workspace 5"
          "workspace 5"
        ];
        alt-shift-6 = [
          "move-node-to-workspace 6"
          "workspace 6"
        ];
        alt-shift-7 = [
          "move-node-to-workspace 7"
          "workspace 7"
        ];
        alt-shift-8 = [
          "move-node-to-workspace 8"
          "workspace 8"
        ];
        alt-shift-9 = [
          "move-node-to-workspace 9"
          "workspace 9"
        ];
        alt-shift-0 = [
          "move-node-to-workspace 10"
          "workspace 10"
        ];
      };
    };
  };

  environment.shells = [ pkgs.fish ];

  sops = {
    age.keyFile = "/Users/${prefs.data.username}/Library/Application Support/sops/age/keys.txt";
  };

  system = {
    primaryUser = prefs.data.username;
    stateVersion = 6;
  };
}
