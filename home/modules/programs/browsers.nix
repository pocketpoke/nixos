{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brave
    mullvad-browser
    tor-browser
  ];
}
