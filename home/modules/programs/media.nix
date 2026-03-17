{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # vlc
    imgbrd-grabber
  ];
}
