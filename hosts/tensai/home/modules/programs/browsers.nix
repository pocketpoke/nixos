{ pkgs, ... }:

{
  home.packages = with pkgs; [
    librewolf
    mullvad-browser
    tor-browser
  ];
}
