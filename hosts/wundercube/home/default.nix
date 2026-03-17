{ ... }:

{
  home.username = "user";
  home.stateVersion = "25.11";

  imports = [
    ../../common/home

    ./modules/programs
  ];
}
