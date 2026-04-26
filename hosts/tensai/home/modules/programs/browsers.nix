{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brave
    librewolf
    mullvad-browser
    tor-browser
  ];
}
