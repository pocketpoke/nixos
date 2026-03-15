{
  inputs,
  ...
}:

{
  home.username = "user";
  home.stateVersion = "25.11";

  imports = [
    inputs.nixcord.homeModules.nixcord
    inputs.plasma-manager.homeModules.plasma-manager

    ../modules/programs
  ];
}
