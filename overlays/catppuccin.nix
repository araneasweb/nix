final: prev: {
  catppuccin-gtk = prev.catppuccin-gtk.override {
    accents = [ "mauve" ];
    size = "standard";
    variant = "mocha";
  };

  catppuccin-papirus-folders = prev.catppuccin-papirus-folders.override {
    accent = "mauve";
    flavor = "mocha";
  };
}
