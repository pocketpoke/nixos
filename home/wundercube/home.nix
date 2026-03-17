{
  inputs,
  ...
}:

{
  home.username = "user";
  home.stateVersion = "25.11";

  imports = [
    inputs.nixcord.homeModules.nixcord

    ../modules/programs
  ];
}
