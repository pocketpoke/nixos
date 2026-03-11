{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    # Core
    ../../modules/core

    # Boot & storage
    ../../modules/boot

    # Hardware features
    ../../modules/hardware

    # Desktop / GUI
    ../../modules/desktop

    # Networking
    ../../modules/networking

    # Services & programs
    ../../modules/services

    # Shell
    ../../modules/shell

    # Users
    ../../modules/users
  ];

  networking.hostName = "tensai";

  system.stateVersion = "25.05";
}
