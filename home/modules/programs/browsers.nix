{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # librewolf
    brave
    # mullvad-browser
    # tor-browser
  ];
}
