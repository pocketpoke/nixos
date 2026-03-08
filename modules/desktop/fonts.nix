{ pkgs, ... }:

{
  fonts.enableDefaultPackages = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
  ];

  fonts.fontconfig.defaultFonts = {
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

  fonts.fontconfig.antialias = true;
  fonts.fontconfig.hinting.enable = true;
  fonts.fontconfig.hinting.style = "slight";
}
