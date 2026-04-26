{ ... }:

{
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "25.05";

  imports = [
    ./modules/desktop
    ./modules/programs
  ];
}
