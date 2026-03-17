{ inputs, ... }:

{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager

    ./kde-packages.nix
    ./plasma.nix
    ./qt-theming.nix
    ./xdg-portals.nix
  ];
}
