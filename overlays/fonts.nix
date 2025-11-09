_: prev: {
  hack-font-ligature-nerd = prev.stdenvNoCC.mkDerivation {
    pname = "hack-font-ligature-nerd-font";
    version = "1";

    src = prev.fetchFromGitHub {
      owner = "pyrho";
      repo = "hack-font-ligature-nerd-font";
      rev = "master";
      hash = "sha256-haURxyxy0vWzkrXR8B65Lzi2wLjc34YiT3O4rv7BTKA=";
    };

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/fonts/truetype

      cp "font/Hack Regular Nerd Font Complete Mono.ttf" $out/share/fonts/truetype/
      cp "font/Hack Bold Nerd Font Complete Mono.ttf" $out/share/fonts/truetype/
      cp "font/Hack Italic Nerd Font Complete Mono.ttf" $out/share/fonts/truetype/
      cp "font/Hack Bold Italic Nerd Font Complete Mono.ttf" $out/share/fonts/truetype/

      runHook postInstall
    '';

    meta = with prev.lib; {
      description = "hack-font-ligature-nerd-font";
      homepage = "https://github.com/pyrho/hack-font-ligature-nerd-font";
      license = licenses.mit;
      platforms = platforms.all;
    };
  };
}
