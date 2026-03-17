{ inputs, ... }:

{
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "25.05";

  imports = [
    inputs.nixcord.homeModules.nixcord
    inputs.plasma-manager.homeModules.plasma-manager

    ./modules/desktop
    ./modules/programs
  ];
}
