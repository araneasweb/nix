{
  config,
  pkgs,
  ...
}: {
  home.file.".xmonad/./xmonad.hs".source = ./xmonad.hs;

  home.file.".config/nitrogen/bg-saved.cfg".text = ''
    [xin_-1]
    file=/etc/nixos/assets/wallpaper.jpg
    mode=5
    bgcolor=#000000
  '';
}
