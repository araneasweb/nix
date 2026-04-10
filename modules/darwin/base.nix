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

  environment.shells = [ pkgs.fish ];

  sops = {
    age.keyFile = "/Users/${prefs.data.username}/Library/Application Support/sops/age/keys.txt";
  };

  system = {
    primaryUser = prefs.data.username;
    stateVersion = 6;
  };
}
