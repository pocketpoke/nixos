{ ... }:

{
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "25.05";

  imports = [
    ../../common/home

    ./modules/desktop
    ./modules/programs
  ];
}
