{ pkgs, ... }: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
    ];
    fontconfig = {
      defaultFonts = {
        serif = [
          "Noto Serif"
          "Noto Serif CJK JP"
        ];
        sansSerif = [
          "Noto Sans"
          "Noto Sans CJK JP"
        ];
        monospace = [
          "JetBrainsMono Nerd Font"
          "Noto Sans Mono CJK JP"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
      antialias = true;
      hinting.enable = true;
      hinting.style = "slight";
    };
  };
}
