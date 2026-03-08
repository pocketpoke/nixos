{ inputs, ... }:

{
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "25.05";

  imports = [
    inputs.nixcord.homeModules.nixcord
    inputs.plasma-manager.homeModules.plasma-manager

    ./modules/10-desktop
    ./modules/20-programs
    ./modules/30-desktop-entries
  ];
}
